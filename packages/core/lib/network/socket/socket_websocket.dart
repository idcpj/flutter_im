import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:core/exceptions/exceptions.dart';

import 'socket_interface.dart';

class SocketWebSocket implements SocketAbstract {
  WebSocketChannel? _channel;
  final _messageController = StreamController<dynamic>.broadcast();
  final _errorController = StreamController<dynamic>.broadcast();
  final _connectedController = StreamController<bool>.broadcast();
  bool _isConnected = false;

  @override
  bool get isConnected => _isConnected;

  @override
  Stream<dynamic> get onMessage => _messageController.stream;

  @override
  Stream<dynamic> get onError => _errorController.stream;

  @override
  Stream<bool> get onConnected => _connectedController.stream;

  @override
  Future<void> connect(String host, int port) async {
    try {
      final uri = Uri.parse('ws://$host:$port');
      _channel = IOWebSocketChannel.connect(uri);
      _isConnected = true;
      _connectedController.add(true);
      debugPrint('[socket] WebSocket连接成功: $uri');

      // 监听消息
      _channel!.stream.listen(
        (dynamic data) {
          debugPrint('[socket] 收到消息: $data');
          _messageController.add(data);
        },
        onError: (error) {
          debugPrint('[socket] 错误: $error');
          _errorController.add(error);
          _isConnected = false;
          _connectedController.add(false);
        },
        onDone: () {
          debugPrint('[socket] 连接关闭');
          _isConnected = false;
          _connectedController.add(false);
        },
      );
    } catch (e) {
      _isConnected = false;
      _errorController.add(e);
      throw HttpException('WebSocket连接失败: $e');
    }
  }

  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _isConnected = false;
    _connectedController.add(false);
    debugPrint('[socket] WebSocket连接已关闭');
  }

  @override
  Future<void> send(dynamic data) async {
    if (!_isConnected) {
      throw HttpException('WebSocket未连接');
    }

    try {
      final message = data is String ? data : jsonEncode(data);
      _channel!.sink.add(message);
      debugPrint('[socket] 发送消息: $message');
    } catch (e) {
      _errorController.add(e);
      throw HttpException('发送消息失败: $e');
    }
  }

  void dispose() {
    _messageController.close();
    _errorController.close();
    _connectedController.close();
    disconnect();
  }
}
