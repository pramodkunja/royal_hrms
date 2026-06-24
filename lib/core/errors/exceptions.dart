import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class ApiException extends AppException {
  const ApiException(super.message, {super.statusCode, this.errors});

  final Map<String, dynamic>? errors;
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message, {this.errors});

  final Map<String, List<String>>? errors;
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class UnknownException extends AppException {
  const UnknownException(super.message);
}

AppException mapDioExceptionToAppException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const RequestTimeoutException('The connection has timed out.');
    case DioExceptionType.connectionError:
      return const NetworkException(
        'Unable to reach the server. Check your internet connection.',
      );
    case DioExceptionType.cancel:
      return const UnknownException('The request was cancelled.');
    case DioExceptionType.badCertificate:
      return const NetworkException('Invalid server certificate.');
    case DioExceptionType.badResponse:
      return _mapBadResponse(error);
    case DioExceptionType.unknown:
      return UnknownException(error.message ?? 'An unexpected error occurred.');
  }
}

AppException _mapBadResponse(DioException error) {
  final statusCode = error.response?.statusCode;
  final data = error.response?.data;
  final message = _extractMessage(data) ?? 'Something went wrong. Please try again.';

  if (statusCode == 401) {
    return UnauthorizedException(message);
  }
  if (statusCode == 422) {
    return ValidationException(message, errors: _extractValidationErrors(data));
  }
  return ApiException(
    message,
    statusCode: statusCode,
    errors: data is Map<String, dynamic> ? data : null,
  );
}

String? _extractMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    final message = data['message'];
    if (message is String) return message;
  }
  return null;
}

Map<String, List<String>>? _extractValidationErrors(dynamic data) {
  if (data is Map<String, dynamic> && data['errors'] is Map<String, dynamic>) {
    final rawErrors = data['errors'] as Map<String, dynamic>;
    return rawErrors.map(
      (key, value) => MapEntry(key, value is List ? value.cast<String>() : <String>[]),
    );
  }
  return null;
}
