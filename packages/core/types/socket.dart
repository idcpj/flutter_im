import 'dart:typed_data';

import 'types.dart';

abstract class SocketAbstract {
  // 连接状态
  bool get isConnected;

  // 连接服务器
  Future<void> connect(String host, int port);

  // 断开连接
  void disconnect();

  // 发送数据
  void send(Uint8List data);

  // 绑定回调
  void bind(TcpCallback data);
}
