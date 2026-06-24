import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Centralized application logger. Wraps the `logger` package so every
/// layer logs through one configured instance instead of raw `print`.
class LoggerService {
  LoggerService() : _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  final Logger _logger;

  void debug(String message) => _logger.d(message);

  void info(String message) => _logger.i(message);

  void warning(String message) => _logger.w(message);

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

final loggerServiceProvider = Provider<LoggerService>((ref) => LoggerService());
