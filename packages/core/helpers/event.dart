import 'dart:async';

import '../types/types.dart';

class EventBus extends EventBusAbstract {
  final _controllers = <CmdCode, StreamController<Message>>{};

  /// 订阅指定cmdCode的消息
  Stream<Message> on(CmdCode cmdCode) {
    _controllers[cmdCode] ??= StreamController<Message>.broadcast();
    return _controllers[cmdCode]!.stream;
  }

  /// 发布消息
  void emit(CmdCode cmdCode, Message message) {
    _controllers[cmdCode]?.add(message);
  }

  /// 取消订阅指定cmdCode
  void off(CmdCode cmdCode) {
    _controllers[cmdCode]?.close();
    _controllers.remove(cmdCode);
  }

  /// 清理所有订阅
  void dispose() {
    for (var controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }
}
