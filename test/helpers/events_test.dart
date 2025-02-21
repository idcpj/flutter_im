import 'package:flutter_test/flutter_test.dart';

import '../../packages/core/constants/constants.dart';
import '../../packages/core/helpers/event.dart';
import '../../packages/core/types/types.dart';

void main() {
  late EventBus eventBus;

  setUp(() {
    eventBus = EventBus();
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
  });
}
