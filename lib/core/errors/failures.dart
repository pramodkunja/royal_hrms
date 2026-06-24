import 'package:freezed_annotation/freezed_annotation.dart';

import 'exceptions.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server(String message, {int? statusCode}) = ServerFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.unauthorized(String message) = UnauthorizedFailure;
  const factory Failure.validation(
    String message, {
    Map<String, List<String>>? errors,
  }) = ValidationFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.unknown(String message) = UnknownFailure;

  factory Failure.fromException(AppException exception) {
    switch (exception) {
      case ApiException():
        return Failure.server(exception.message, statusCode: exception.statusCode);
      case NetworkException():
        return Failure.network(exception.message);
      case RequestTimeoutException():
        return Failure.network(exception.message);
      case UnauthorizedException():
        return Failure.unauthorized(exception.message);
      case ValidationException():
        return Failure.validation(exception.message, errors: exception.errors);
      case CacheException():
        return Failure.cache(exception.message);
      case UnknownException():
        return Failure.unknown(exception.message);
      default:
        return Failure.unknown(exception.message);
    }
  }
}
