import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../services/auth_status_notifier.dart';
import '../services/logger_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';

/// Default in-memory jar — overridden at startup in main.dart with a
/// PersistCookieJar so mobile sessions survive app restarts.
final cookieJarProvider = Provider<CookieJar>((ref) => CookieJar());

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: ApiConstants.baseUrl,
  connectTimeout: ApiConstants.connectTimeout,
  receiveTimeout: ApiConstants.receiveTimeout,
  sendTimeout: ApiConstants.sendTimeout,
  contentType: ApiConstants.applicationJson,
);

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.get<T>(path,
          queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.post<T>(path,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.put<T>(path,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.patch<T>(path,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.delete<T>(path,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> _guard<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      final mapped = error.error;
      throw mapped is AppException
          ? mapped
          : mapDioExceptionToAppException(error);
    }
  }
}

/// Bare Dio used only for token-refresh calls. Shares the cookie jar so
/// the royal_refresh_token cookie is included; has no AuthInterceptor to
/// avoid recursion.
final refreshDioProvider = Provider<Dio>((ref) {
  final dio = Dio(_baseOptions());
  if (!kIsWeb) {
    dio.interceptors.add(CookieManager(ref.watch(cookieJarProvider)));
  } else {
    (dio.httpClientAdapter as dynamic).withCredentials = true;
  }
  return dio;
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(_baseOptions());
  final logger = ref.watch(loggerServiceProvider);

  if (!kIsWeb) {
    // Mobile/desktop: CookieManager reads Set-Cookie from responses and
    // injects Cookie headers into requests automatically.
    dio.interceptors.add(CookieManager(ref.watch(cookieJarProvider)));
  } else {
    // Web: instruct the browser XHR adapter to include HttpOnly cookies
    // in cross-origin requests (requires CORS Allow-Credentials on server).
    (dio.httpClientAdapter as dynamic).withCredentials = true;
  }

  dio.interceptors.addAll([
    RequestInterceptor(logger),
    AuthInterceptor(
      refreshDio: ref.watch(refreshDioProvider),
      retryDio: dio,
      onSessionExpired: () =>
          ref.read(authStatusNotifierProvider.notifier).setUnauthenticated(),
    ),
    ResponseInterceptor(logger),
    ErrorInterceptor(logger),
  ]);

  return dio;
});

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(dioProvider)),
);
