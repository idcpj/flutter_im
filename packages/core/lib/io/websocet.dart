import 'dart:typed_data';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:core/types/types.dart';

class Websocet extends SocketAbstract {
  WebSocketChannel? _socket;
  TcpCallback? _handle;
  LogAbstract _log;

  @override
  bool get isConnected => _socket != null;

  Websocet({
    required LogAbstract log,
  }) : _log = log;

  @override
  Future<void> connect(String host, int port) async {
    _log.info('Connecting to: $host:$port');

    final wsUrl = 'ws://$host:$port';
    _socket = IOWebSocketChannel.connect(wsUrl);
    _log.info('Connected to: $wsUrl');

    _socket!.stream.listen(
      (dynamic data) {
        if (data is List<int>) {
          _handle?.call(Uint8List.fromList(data));
        }
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

  @override
  void send(Uint8List data) {
    if (!isConnected) {
      _log.error('Not connected to server');
      return;
    }
    _log.debug('Sending data: ${data.length} bytes');

    _socket!.sink.add(data);

    _log.debug('Sent data: ${data.length} bytes');
  }

  @override
  void disconnect() {
    _socket?.sink.close();
    _socket = null;
  }
}
