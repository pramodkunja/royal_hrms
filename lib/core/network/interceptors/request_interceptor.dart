import 'package:dio/dio.dart';

import '../../services/logger_service.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor(this._logger);

  final LoggerService _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug(
      '--> ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Body: ${options.data}',
    );
    handler.next(options);
  }
}
