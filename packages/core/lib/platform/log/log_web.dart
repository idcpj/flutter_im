import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'package:core/types/types.dart';

class LogWeb implements LogAbstract {
  final Logger _logger = Logger('WebLogger');

  @override
  Future<void> initialization(String customLogPath, LogLevel level) async {
    if (level.name == "debug") {
      _logger.level = Level.FINE;
    } else if (level.name == "info") {
      _logger.level = Level.INFO;
    } else {
      _logger.level = Level.ALL;
    }

    _logger.onRecord.listen((record) {
      debugPrint('${record.time}: ${record.level.name}: ${record.message}');
      if (record.error != null) {
        debugPrint('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint('StackTrace: ${record.stackTrace}');
      }
    });
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
