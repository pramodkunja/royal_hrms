import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../services/auth_status_notifier.dart';
import '../services/logger_service.dart';
import '../storage/token_storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: ApiConstants.baseUrl,
  connectTimeout: ApiConstants.connectTimeout,
  receiveTimeout: ApiConstants.receiveTimeout,
  sendTimeout: ApiConstants.sendTimeout,
  contentType: ApiConstants.applicationJson,
);

/// Centralized HTTP client. All feature data sources talk to the API
/// exclusively through this class rather than constructing their own
/// [Dio] instance.
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
      () =>
          _dio.get<T>(path, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Routes every request through here so callers only ever see
  /// [AppException] (see core/errors/exceptions.dart) and never a raw
  /// [DioException], per the project's error-handling standard.
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

/// Bare instance (no interceptors) reserved for the refresh-token call so
/// the auth interceptor never recurses into itself.
final refreshDioProvider = Provider<Dio>((ref) => Dio(_baseOptions()));

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(_baseOptions());
  final logger = ref.watch(loggerServiceProvider);

  dio.interceptors.addAll([
    RequestInterceptor(logger),
    AuthInterceptor(
      tokenStorageService: ref.watch(tokenStorageServiceProvider),
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
