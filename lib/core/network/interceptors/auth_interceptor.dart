import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../../services/auth_storage.dart';

/// Handles token injection and silent refresh for Bearer-token auth.
///   1. Injects `Authorization: Bearer <token>` on every outgoing request.
///   2. On a 401, reads the stored refresh token, POSTs it to the refresh
///      endpoint, saves the new tokens, and retries the original request.
///   3. Falls back to [onSessionExpired] and clears tokens on failure.
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
    final token = await getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
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

    try {
      _isRefreshing = true;
      final refreshed = await _refreshAccessToken();
      if (!refreshed) {
        await clearTokens();
        await onSessionExpired?.call();
        handler.next(err);
        return;
      }

      final retryOptions = err.requestOptions..extra['retried'] = true;
      final response = await _retryDio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (_) {
      await clearTokens();
      await onSessionExpired?.call();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final storedRefresh = await getRefreshToken();
      if (storedRefresh == null || storedRefresh.isEmpty) return false;

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

      if (newAccess.isEmpty) return false;

      await saveTokens(newAccess, newRefresh);
      return true;
    } catch (_) {
      return false;
    }
  }
}
