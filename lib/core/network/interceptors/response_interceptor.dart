import 'package:dio/dio.dart';

import '../../services/logger_service.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor(this._logger);

  final LoggerService _logger;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.debug(
      '<-- ${response.statusCode} ${response.requestOptions.uri}\n'
      'Body: ${response.data}',
    );
    handler.next(response);
  }
}
