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
  final message =
      _extractMessage(data) ?? 'Something went wrong. Please try again.';

  if (statusCode == 401) {
    return UnauthorizedException(message);
  }
  if (statusCode == 400 || statusCode == 422) {
    return ValidationException(message, errors: _extractValidationErrors(data));
  }
  return ApiException(
    message,
    statusCode: statusCode,
    errors: data is Map<String, dynamic> ? data : null,
  );
}

/// Backends vary in how they shape error bodies. This checks, in order:
/// a custom `{"message": "..."}` envelope, DRF's default
/// `{"detail": "..."}`, then falls back to the first string (or first
/// item of a string list) found anywhere in the body — covering DRF's
/// flat serializer-validation shape `{"email": ["This field is required."]}`.
String? _extractMessage(dynamic data) {
  if (data is! Map<String, dynamic>) return null;

  final message = data['message'];
  if (message is String && message.isNotEmpty) return message;

  final detail = data['detail'];
  if (detail is String && detail.isNotEmpty) return detail;

  for (final value in data.values) {
    if (value is String && value.isNotEmpty) return value;
    if (value is List && value.isNotEmpty && value.first is String) {
      return value.first as String;
    }
  }
  return null;
}

/// Reads field-level validation errors from either a custom envelope
/// (`{"data": {"email": [...]}}`) or DRF's flat shape
/// (`{"email": [...]}` with no envelope wrapper at all).
Map<String, List<String>>? _extractValidationErrors(dynamic data) {
  if (data is! Map<String, dynamic>) return null;

  final nested = data['data'];
  final isEnvelope = data.containsKey('status') || data.containsKey('message');
  final source = nested is Map<String, dynamic>
      ? nested
      : (isEnvelope ? null : data);
  if (source == null) return null;

  final errors = <String, List<String>>{};
  source.forEach((key, value) {
    if (value is List) {
      final strings = value.whereType<String>().toList();
      if (strings.isNotEmpty) errors[key] = strings;
    } else if (value is String) {
      errors[key] = [value];
    }
  });
  return errors.isEmpty ? null : errors;
}
