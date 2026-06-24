import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
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
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
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
      onSessionExpired: () => ref.read(authStatusNotifierProvider.notifier).setUnauthenticated(),
    ),
    ResponseInterceptor(logger),
    ErrorInterceptor(logger),
  ]);

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref.watch(dioProvider)));
