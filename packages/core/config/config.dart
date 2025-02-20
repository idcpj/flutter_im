class NetConfig {
  String host;
  int port;

  NetConfig({required this.host, required this.port});
}

class LogConfig {
  String path;

  LogConfig({this.path = ""});
}

class AppConfig {
  NetConfig net;
  LogConfig log;

  AppConfig({required NetConfig net, required LogConfig log})
      : net = net,
        log = log;
}
