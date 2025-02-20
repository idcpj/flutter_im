class NetConfig {
  String host;
  int port;

  NetConfig({required this.host, required this.port});
}

class LogConfig {
  String path;

  LogConfig({this.path = ""});
}

class DbConfig {
  String path;
  String dbName;

  DbConfig({required this.path, required this.dbName});
}

class AppConfig {
  NetConfig net;
  LogConfig log;
  DbConfig db;

  AppConfig({required this.net, required this.log, required this.db});
}
