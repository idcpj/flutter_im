import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'package:core/exceptions/exceptions.dart';
import 'package:core/types/types.dart';

class LogWindows implements LogAbstract {
  final Logger _logger = Logger('WindowsLogger');
  late final File _logFile;

  @override
  Future<void> initialization(String customLogPath, LogLevel level) async {
    if (level.name == "debug") {
      _logger.level = Level.FINE;
    } else if (level.name == "info") {
      _logger.level = Level.INFO;
    } else {
      _logger.level = Level.ALL;
    }

    final logPath = path.join(customLogPath, 'im_log_${DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '_')}.log');

    debugPrint('[log] 日志路径: $logPath');

    // 确保日志目录存在
    final logDir = Directory(path.dirname(logPath));
    if (!logDir.existsSync()) {
      logDir.createSync(recursive: true);

      if (!logDir.existsSync()) {
        throw InitializeException('[log] 创建日志目录失败');
      }
    }

    _logFile = File(logPath);
    if (!_logFile.existsSync()) {
      _logFile.createSync(recursive: true);
      if (!_logFile.existsSync()) {
        throw InitializeException('[log] 创建日志文件失败');
      }
    }

    // 配置日志处理
    _logger.onRecord.listen((LogRecord record) {
      final message = '${record.time}: ${record.level.name}: ${record.message}';

      // 控制台输出
      debugPrint(message);

      // 文件输出
      _logFile.writeAsStringSync('$message\n', mode: FileMode.append);

      // 如果有错误和堆栈跟踪，也记录它们
      if (record.error != null) {
        final errorMsg = 'Error: ${record.error}';
        debugPrint(errorMsg);
        _logFile.writeAsStringSync('$errorMsg\n', mode: FileMode.append);
      }

      if (record.stackTrace != null) {
        final stackMsg = 'StackTrace: ${record.stackTrace}';
        debugPrint(stackMsg);
        _logFile.writeAsStringSync('$stackMsg\n', mode: FileMode.append);
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
