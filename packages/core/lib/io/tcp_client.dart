import 'dart:io';
import 'dart:typed_data';

import 'package:core/types/types.dart';

class TcpClient extends SocketAbstract {
  Socket? _socket;
  TcpCallback? _handle;
  LogAbstract _log;

  // 连接状态
  @override
  bool get isConnected => _socket != null;

  TcpClient({required LogAbstract log}) : _log = log;

  // 连接服务器
  @override
  Future<void> connect(String host, int port) async {
    _log.info('Connecting to: $host:$port');

    _socket = await Socket.connect(host, port);
    _log.info('Connectend to: $host:$port');

    // 监听数据
    _socket!.listen(
      (Uint8List data) {
        _handle?.call(data);
      },
      onError: (error) {
        _log.error('Error: $error');
        disconnect();
      },
      onDone: () {
        _log.info('Server disconnected');
        disconnect();
      },
    );
  }

  @override
  bind(TcpCallback data) {
    _handle = data;
  }

  // 发送数据
  @override
  void send(Uint8List data) {
    if (!isConnected) {
      _log.error('Not connected to server');
      return;
    }
    // _log.debug('Sending data: ${data.length} bytes');

    // 将 Uint8List 转换为字节流并发送
    _socket!.add(data);

    // _log.debug('Sent data: ${data.length} bytes');
  }

  // 断开连接
  @override
  void disconnect() {
    _socket?.destroy();
    _socket = null;
  }
}
