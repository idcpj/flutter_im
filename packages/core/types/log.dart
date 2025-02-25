part of 'types.dart';

abstract class LogAbstract {
  Future<void> initialization(String customLogPath, LogLevel level);

  void debug(String message, [Object? error, StackTrace? stackTrace]);
  void info(String message, [Object? error, StackTrace? stackTrace]);
  void warning(String message, [Object? error, StackTrace? stackTrace]);
  void error(String message, [Object? error, StackTrace? stackTrace]);
  void critical(String message, [Object? error, StackTrace? stackTrace]);
}

enum LogLevel {
  all("debug"),
  debug("info");

  final String name;
  const LogLevel(this.name);
}
