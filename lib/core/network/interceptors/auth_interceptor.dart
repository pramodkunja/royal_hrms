import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../../services/auth_storage.dart';

enum _RefreshResult { success, refreshFailed, storageUnavailable }

/// Handles token injection and silent refresh for Bearer-token auth.
///   1. Injects `Authorization: Bearer <token>` on every outgoing request.
///   2. On a 401, reads the stored refresh token, POSTs it to the refresh
///      endpoint, saves the new tokens, and retries the original request.
///   3. Falls back to [onSessionExpired] and clears tokens on confirmed failure.
///
/// On Flutter Web, flutter_secure_storage_web uses Web Crypto API and may
/// throw a native OperationError if the encryption key is unavailable.
/// Those errors are caught so a transient storage failure does NOT expire
/// the user's session unexpectedly.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio refreshDio,
    required Dio retryDio,
    this.onSessionExpired,
  })  : _refreshDio = refreshDio,
        _retryDio = retryDio;

  final Dio _refreshDio;
  final Dio _retryDio;
  final Future<void> Function()? onSessionExpired;

  bool _isRefreshing = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
      // flutter_secure_storage_web throws a native Web Crypto OperationError
      // when no token is stored yet or the encryption key is unavailable.
      // Proceed without a token; the server will return 401 if auth is needed.
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isRetry = err.requestOptions.extra['retried'] == true;

    if (!isUnauthorized || isRetry || _isRefreshing) {
      handler.next(err);
      return;
    }

    _isRefreshing = true;
    try {
      final result = await _tryRefreshAccessToken();

      switch (result) {
        case _RefreshResult.storageUnavailable:
          // Secure storage threw — cannot confirm session truly expired.
          // Pass 401 through so the calling provider handles it gracefully
          // (e.g. show empty state) instead of logging the user out.
          handler.next(err);

        case _RefreshResult.refreshFailed:
          await _safelyExpireSession();
          handler.next(err);

        case _RefreshResult.success:
          final retryOptions = err.requestOptions..extra['retried'] = true;
          final response = await _retryDio.fetch<dynamic>(retryOptions);
          handler.resolve(response);
      }
    } catch (_) {
      await _safelyExpireSession();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _safelyExpireSession() async {
    try {
      await clearTokens();
    } catch (_) {}
    await onSessionExpired?.call();
  }

  Future<_RefreshResult> _tryRefreshAccessToken() async {
    String? storedRefresh;
    try {
      storedRefresh = await getRefreshToken();
    } catch (_) {
      return _RefreshResult.storageUnavailable;
    }

    if (storedRefresh == null || storedRefresh.isEmpty) {
      return _RefreshResult.refreshFailed;
    }

    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        ApiConstants.refreshTokenEndpoint,
        data: {'refresh': storedRefresh},
      );

      final body = response.data;
      final data = body?['data'] is Map
          ? body!['data'] as Map<String, dynamic>
          : <String, dynamic>{};
      final newAccess = data['access'] as String? ?? '';
      final newRefresh = data['refresh'] as String? ?? storedRefresh;

      if (newAccess.isEmpty) return _RefreshResult.refreshFailed;

      await saveTokens(newAccess, newRefresh);
      return _RefreshResult.success;
    } catch (_) {
      return _RefreshResult.refreshFailed;
    }
  }
}
