import 'dart:io';
import 'dart:typed_data';

import '../types/log.dart';
import '../types/types.dart';

class TcpClient {
  Socket? _socket;
  TcpBindHandle? _handle;
  LogAbstract? _log;

  String? host;
  int? port;

  // 连接状态
  bool get isConnected => _socket != null;

  TcpClient({LogAbstract? log});

  // 连接服务器
  Future<void> connect(String host, int port) async {
    if (host.isEmpty) {
      throw ArgumentError('Host is null or empty');
    }
    if (port <= 0) {
      throw ArgumentError('Port is less than 0');
    }

    _socket = await Socket.connect(host, port);
    _log?.info('Connected to: $host:$port');

    // 监听数据
    _socket!.listen(
      (Uint8List data) {
        _handle?.call(data);
      },
      onError: (error) {
        _log?.error('Error: $error');
        disconnect();
      },
      onDone: () {
        _log?.info('Server disconnected');
        disconnect();
      },
    );
  }

  bind_handle_data(TcpBindHandle data) {
    _handle = data;
  }

  // 发送数据
  Future<void> send(String data) async {
    if (!isConnected) {
      throw Exception('Not connected to server');
    }
    _socket!.write(data);
    // 刷新缓冲区
    await _socket!.flush();
  }

  // 断开连接
  void disconnect() {
    _socket?.destroy();
    _socket = null;
  }
}
