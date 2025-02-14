import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../exceptions/exceptions.dart';
import 'socket_interface.dart';

class SocketTCP implements SocketAbstract {
  Socket? _socket;
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
      _socket = await Socket.connect(host, port);
      _isConnected = true;
      _connectedController.add(true);
      debugPrint('[socket] TCP连接成功: $host:$port');

      // 监听数据
      _socket!.listen(
        (List<int> data) {
          final message = utf8.decode(data);
          debugPrint('[socket] 收到消息: $message');
          _messageController.add(message);
        },
        onError: (error) {
          debugPrint('[socket] 错误: $error');
          _errorController.add(error);
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
      throw HttpException('TCP连接失败: $e');
    }
  }

  @override
  Future<void> disconnect() async {
    await _socket?.close();
    _isConnected = false;
    _connectedController.add(false);
    debugPrint('[socket] TCP连接已关闭');
  }

  @override
  Future<void> send(dynamic data) async {
    if (!_isConnected) {
      throw HttpException('TCP未连接');
    }

    try {
      final message = data is String ? data : jsonEncode(data);
      _socket!.write(message);
      await _socket!.flush();
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
