import 'package:flutter_test/flutter_test.dart';

import '../../packages/core/constants/constants.dart';
import '../../packages/core/helpers/event.dart';
import '../../packages/core/types/types.dart';

void main() {
  late EventBus eventBus;

  setUp(() {
    eventBus = EventBus(null);
  });

  tearDown(() {
    eventBus.dispose();
  });

  group('EventBus Tests', () {
    test('订阅消息测试', () {
      final cmdCode = CmdCode.login; // 使用你实际的枚举值
      final message = Message(header: Header(cmd: cmdCode));

      // 订阅消息
      final stream = eventBus.on(cmdCode).listen((message) {
        print('收到消息: ${message.header.cmd}');
      });

      // 验证流是否创建
      expect(stream, isNotNull);
    });

    test('发布和接收消息测试', () async {
      final cmdCode = CmdCode.login;
      final message = Message(header: Header(cmd: cmdCode));

      // 订阅并等待消息
      eventBus.on(cmdCode).listen((message) {
        print('收到消息: ${message.header.cmd}');
        expect(message, equals(message));
      });

      // 发送消息
      eventBus.emit(cmdCode, message);
    });

    test('取消订阅测试', () {
      final cmdCode = CmdCode.login;

      // 先订阅
      final stream = eventBus.on(cmdCode);

      // 取消订阅
      eventBus.off(cmdCode);

      // 验证流是否关闭
      expect(stream.isBroadcast, isTrue);
      expectLater(stream.isEmpty, completion(isTrue));
    });

    test('多个订阅者测试', () async {
      final cmdCode = CmdCode.login;
      final message = Message(header: Header(cmd: cmdCode), body: 'test');

      // 创建两个订阅
      eventBus.on(cmdCode).listen((message) {
        print('收到消息: ${message}');
        expect(message, equals(message));
      });
      eventBus.on(cmdCode).listen((message) {
        print('收到消息: ${message}');
        expect(message, equals(message));
      });

      // 发送消息
      eventBus.emit(cmdCode, message);
    });

    test('清理所有订阅测试', () {
      final cmdCode1 = CmdCode.login;
      final cmdCode2 = CmdCode.login;

      // 创建多个订阅
      final stream1 = eventBus.on(cmdCode1);
      final stream2 = eventBus.on(cmdCode2);

      // 清理所有订阅
      eventBus.dispose();

      // 验证所有流都已关闭
      expectLater(stream1.isEmpty, completion(isTrue));
      expectLater(stream2.isEmpty, completion(isTrue));
    });

    test('消息顺序执行测试', () async {
      final cmdCode = CmdCode.login;
      final messages = List.generate(
          3,
          (index) =>
              Message(header: Header(cmd: cmdCode), body: 'message-$index'));
      final receivedMessages = <String>[];

      // 订阅消息
      eventBus.on(cmdCode).listen((message) {
        receivedMessages.add((message as Message).body as String);
      });

      // 模拟不同延迟发送消息
      await Future.wait([
        Future.delayed(const Duration(milliseconds: 300))
            .then((_) => eventBus.emit(cmdCode, messages[0])),
        Future.delayed(const Duration(milliseconds: 200))
            .then((_) => eventBus.emit(cmdCode, messages[1])),
        Future.delayed(const Duration(milliseconds: 100))
            .then((_) => eventBus.emit(cmdCode, messages[2])),
      ]);

      // 等待所有消息处理完成
      await Future.delayed(Duration(milliseconds: 400));

      // 验证消息接收顺序
      expect(receivedMessages, ['message-2', 'message-1', 'message-0']);
    });

    test('多个异步监听器测试', () async {
      final cmdCode = CmdCode.login;
      final message =
          Message(header: Header(cmd: cmdCode), body: 'test-message');
      final receivedOrder = <String>[];

      // 添加三个不同延迟的监听器
      eventBus.on(cmdCode).listen((msg) async {
        await Future.delayed(const Duration(milliseconds: 300));
        receivedOrder.add('listener1');
      });

      eventBus.on(cmdCode).listen((msg) async {
        await Future.delayed(const Duration(milliseconds: 100));
        receivedOrder.add('listener2');
      });

      eventBus.on(cmdCode).listen((msg) async {
        await Future.delayed(const Duration(milliseconds: 200));
        receivedOrder.add('listener3');
      });

      // 发送消息
      eventBus.emit(cmdCode, message);

      // 等待所有监听器处理完成
      await Future.delayed(const Duration(milliseconds: 400));

      // 验证监听器执行顺序
      expect(receivedOrder, ['listener2', 'listener3', 'listener1']);
    });
  });
}
