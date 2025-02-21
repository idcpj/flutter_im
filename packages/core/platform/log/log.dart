import 'package:logging/logging.dart';

import '../../types/types.dart';
import '../../helpers/platform.dart';
import 'log_default.dart';
import 'log_web.dart';
import 'log_windows.dart';

class LogPlatform extends LogAbstract {
  late final LogAbstract _log;

  LogPlatform() {
    hierarchicalLoggingEnabled = true;

    if (Platform.isWeb) {
      _log = LogWeb();
    } else if (Platform.isDesktop) {
      _log = LogWindows();
    } else {
      _log = LogDefault();
    }
  }

  @override
  Future<void> initialization(String customLogPath, LogLevel level) async {
    _log.initialization(customLogPath, level);
  }

  @override
  void debug(String message, [Object? err, StackTrace? stackTrace]) {
    _log.debug(message, err, stackTrace);
  }

  @override
  void info(String message, [Object? err, StackTrace? stackTrace]) {
    _log.info(message, err, stackTrace);
  }

  @override
  void warning(String message, [Object? err, StackTrace? stackTrace]) {
    _log.warning(message, err, stackTrace);
  }

  @override
  void error(String message, [Object? err, StackTrace? stackTrace]) {
    _log.error(message, err, stackTrace);
  }

  @override
  void critical(String message, [Object? err, StackTrace? stackTrace]) {
    _log.critical(message, err, stackTrace);
  }
}
