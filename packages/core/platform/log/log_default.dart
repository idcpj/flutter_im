import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import '../../types/log.dart';

class LogDefault implements LogAbstract {
  final Logger _logger = Logger('DefaultLogger');
  bool _initialized = false;

  LogDefault() {
    _initLogger();
    debugPrint('[log] Default日志初始化成功');
  }

  void _initLogger() {
    if (_initialized) return;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.time}: ${record.level.name}: ${record.message}');
      if (record.error != null) {
        debugPrint('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint('StackTrace: ${record.stackTrace}');
      }
    });

    _initialized = true;
  }

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  @override
  void critical(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.shout(message, error, stackTrace);
  }
}
