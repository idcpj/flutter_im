abstract class SocketAbstract {
  Future<void> connect(String host, int port);
  Future<void> disconnect();
  Future<void> send(dynamic data);
  Stream<dynamic> get onMessage;
  Stream<dynamic> get onError;
  Stream<bool> get onConnected;
  bool get isConnected;
}
