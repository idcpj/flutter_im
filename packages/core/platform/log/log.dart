import '../../types/types.dart';
import '../../helpers/platform.dart';
import 'log_default.dart';
import 'log_windows.dart';

class LogPlatform extends LogAbstract {
  late final LogAbstract _log;

  LogPlatform({String path = ""}) {
    if (Platform.isDesktop) {
      _log = LogWindows(logPath: path);
    } else {
      _log = LogDefault();
    }
  }

  void debug(String message, [Object? err, StackTrace? stackTrace]) {
    _log.debug(message, err, stackTrace);
  }

  void info(String message, [Object? err, StackTrace? stackTrace]) {
    _log.info(message, err, stackTrace);
  }

  void warning(String message, [Object? err, StackTrace? stackTrace]) {
    _log.warning(message, err, stackTrace);
  }

  void error(String message, [Object? err, StackTrace? stackTrace]) {
    _log.error(message, err, stackTrace);
  }

  void critical(String message, [Object? err, StackTrace? stackTrace]) {
    _log.critical(message, err, stackTrace);
  }
}
