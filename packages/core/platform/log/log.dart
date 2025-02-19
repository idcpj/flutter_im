import '../../constants/const.dart';

import '../../types/log.dart';
import 'log_default.dart';
import 'log_windows.dart';
import '../../utils/platform.dart';

class LogPlatform {
  late final LogAbstract _platform;

  // 私有构造函数
  static final LogPlatform instance = LogPlatform._();
  LogPlatform._() {
    if (Platform.isDesktop) {
      _platform = LogWindows(logPath: projectLog);
    } else {
      _platform = LogDefault();
    }
  }

  void debug(String message, [Object? error, StackTrace? stackTrace]) =>
      _platform.debug(message, error, stackTrace);

  void info(String message, [Object? error, StackTrace? stackTrace]) =>
      _platform.info(message, error, stackTrace);

  void warning(String message, [Object? error, StackTrace? stackTrace]) =>
      _platform.warning(message, error, stackTrace);

  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _platform.error(message, error, stackTrace);

  void critical(String message, [Object? error, StackTrace? stackTrace]) =>
      _platform.critical(message, error, stackTrace);
}
