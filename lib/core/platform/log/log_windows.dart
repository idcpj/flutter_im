import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import '../../exceptions/initialize_exception.dart';
import 'log_interface.dart';

class LogWindows implements LogAbstract {
  final Logger _logger = Logger('WindowsLogger');
  late final File _logFile;
  bool _initialized = false;

  LogWindows({String logPath = ''}) {
    _initLogger(logPath);

    debugPrint('[log] Windows日志初始化成功');
  }

  Future<void> _initLogger(String customLogPath) async {
    if (_initialized) return;

    // 设置日志级别
    Logger.root.level = Level.ALL;

    final appDir = await getApplicationDocumentsDirectory();

    final logPath = path.join(appDir.path, customLogPath,
        'log_${DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '_')}.log');

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
    Logger.root.onRecord.listen((LogRecord record) {
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
