import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdco/core/network/socket/socket_tcp.dart';
import 'package:sdco/core/network/socket/socket_websocket.dart';

void main() {
  group('SocketTCP Tests', () {
    late SocketTCP tcpSocket;
    late ServerSocket server;
    const port = 8081;

    setUp(() async {
      tcpSocket = SocketTCP();
      // 创建一个TCP服务器用于测试
      server = await ServerSocket.bind('127.0.0.1', port);
      server.listen((Socket client) {
        // 回显收到的消息
        client.listen((data) {
          client.add(data);
        });
      });
    });

    tearDown(() async {
      tcpSocket.dispose();
      await server.close();
    });

    test('TCP连接测试', () async {
      expect(tcpSocket.isConnected, false);
      await tcpSocket.connect('127.0.0.1', port);
      expect(tcpSocket.isConnected, true);
    });

    test('TCP发送和接收消息测试', () async {
      await tcpSocket.connect('127.0.0.1', port);

      // 监听消息
      String? receivedMessage;
      tcpSocket.onMessage.listen((message) {
        receivedMessage = message;
      });

      // 发送消息
      const testMessage = 'Hello TCP Test';
      await tcpSocket.send(testMessage);

      // 等待接收消息
      await Future.delayed(const Duration(milliseconds: 500));
      expect(receivedMessage, equals(testMessage));
    });

    test('TCP断开连接测试', () async {
      await tcpSocket.connect('127.0.0.1', port);
      expect(tcpSocket.isConnected, true);

      await tcpSocket.disconnect();
      expect(tcpSocket.isConnected, false);
    });
  });

  group('SocketWebSocket Tests', () {
    late SocketWebSocket wsSocket;
    late HttpServer server;
    const port = 8082;

    setUp(() async {
      wsSocket = SocketWebSocket();
      // 创建一个WebSocket服务器用于测试
      server = await HttpServer.bind('127.0.0.1', port);
      server.listen((HttpRequest request) {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          WebSocketTransformer.upgrade(request).then((WebSocket ws) {
            ws.listen((data) {
              // 回显收到的消息
              ws.add(data);
            });
          });
        }
      });
    });

    tearDown(() async {
      wsSocket.dispose();
      await server.close();
    });

    test('WebSocket连接测试', () async {
      expect(wsSocket.isConnected, false);
      await wsSocket.connect('127.0.0.1', port);
      expect(wsSocket.isConnected, true);
    });

    test('WebSocket发送和接收消息测试', () async {
      await wsSocket.connect('127.0.0.1', port);

      // 监听消息
      String? receivedMessage;
      wsSocket.onMessage.listen((message) {
        receivedMessage = message;
      });

      // 发送消息
      const testMessage = 'Hello WebSocket Test';
      await wsSocket.send(testMessage);

      // 等待接收消息
      await Future.delayed(const Duration(milliseconds: 500));
      expect(receivedMessage, equals(testMessage));
    });

    test('WebSocket断开连接测试', () async {
      await wsSocket.connect('127.0.0.1', port);
      expect(wsSocket.isConnected, true);

      await wsSocket.disconnect();
      expect(wsSocket.isConnected, false);
    });
  });
}

//// TCP使用示例
// final tcpSocket = SocketTCP();
// await tcpSocket.connect('127.0.0.1', 8080);
// tcpSocket.onMessage.listen((message) {
//   print('收到TCP消息: $message');
// });
// await tcpSocket.send('Hello TCP');

// // WebSocket使用示例
// final wsSocket = SocketWebSocket();
// await wsSocket.connect('localhost', 8080);
// wsSocket.onMessage.listen((message) {
//   print('收到WebSocket消息: $message');
// });
// await wsSocket.send('Hello WebSocket');
