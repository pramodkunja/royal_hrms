import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../storage/token_storage_service.dart';

/// Attaches the JWT access token to outgoing requests and prepares an
/// automatic refresh-and-retry flow when a request fails with 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorageService tokenStorageService,
    required Dio refreshDio,
    required Dio retryDio,
    this.onSessionExpired,
  }) : _tokenStorageService = tokenStorageService,
       _refreshDio = refreshDio,
       _retryDio = retryDio;

  final TokenStorageService _tokenStorageService;

  /// A bare [Dio] instance (no interceptors) used solely to call the
  /// refresh-token endpoint, avoiding interceptor recursion.
  final Dio _refreshDio;

  /// The application's main [Dio] instance, used to retry the original
  /// request once a new access token has been obtained.
  final Dio _retryDio;

  /// Invoked when the refresh token is missing/expired so the app can
  /// clear the session and navigate back to the login screen.
  final Future<void> Function()? onSessionExpired;

  bool _isRefreshing = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenStorageService.getAccessToken();
    if (accessToken != null) {
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix} $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isRetry = err.requestOptions.extra['retried'] == true;

    if (!isUnauthorized || isRetry || _isRefreshing) {
      handler.next(err);
      return;
    }

    try {
      _isRefreshing = true;
      final refreshedToken = await _refreshAccessToken();
      if (refreshedToken == null) {
        await onSessionExpired?.call();
        handler.next(err);
        return;
      }

      final retryOptions = err.requestOptions
        ..headers[ApiConstants.authorizationHeader] =
            '${ApiConstants.bearerPrefix} $refreshedToken'
        ..extra['retried'] = true;

      final response = await _retryDio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (_) {
      await onSessionExpired?.call();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = await _tokenStorageService.getRefreshToken();
    if (refreshToken == null) return null;

    final response = await _refreshDio.post<Map<String, dynamic>>(
      ApiConstants.refreshTokenEndpoint,
      data: {'refresh_token': refreshToken},
    );

    final newAccessToken = response.data?['access_token'] as String?;
    final newRefreshToken = response.data?['refresh_token'] as String?;
    if (newAccessToken == null) return null;

    await _tokenStorageService.saveTokens(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken ?? refreshToken,
    );
    return newAccessToken;
  }
}
