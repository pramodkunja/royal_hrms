import 'package:dio/dio.dart';

import '../../errors/exceptions.dart';
import '../../services/logger_service.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this._logger);

  final LoggerService _logger;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = mapDioExceptionToAppException(err);
    _logger.error(
      '<-x ${err.requestOptions.method} ${err.requestOptions.uri}',
      error: appException,
      stackTrace: err.stackTrace,
    );
    handler.next(err.copyWith(error: appException));
  }
}
