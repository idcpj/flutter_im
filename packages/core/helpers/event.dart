import 'dart:async';

import '../constants/constants.dart';
import '../types/types.dart';

class EventBus extends EventBusAbstract {
  LogAbstract? log;
  final _controllers = <CmdCode, StreamController<Message>>{};

  EventBus(this.log);

  /// 订阅指定cmdCode的消息
  @override
  Stream<Message> on(CmdCode cmdCode) {
    _controllers[cmdCode] ??= StreamController<Message>.broadcast();
    return _controllers[cmdCode]!.stream;
  }

  /// 发布消息
  @override
  void emit(CmdCode cmdCode, Message message) {
    if (_controllers[cmdCode] == null) {
      log?.debug('[event] 指令不存在: $cmdCode=${cmdCode.value}');
      return;
    }

    _controllers[cmdCode]?.add(message);
  }

  /// 取消订阅指定cmdCode
  @override
  void off(CmdCode cmdCode) {
    _controllers[cmdCode]?.close();
    _controllers.remove(cmdCode);
  }

  /// 清理所有订阅
  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }
}
