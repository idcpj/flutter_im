import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'notification_interface.dart';

class NotificationDefault implements NotificationAbstract {
  bool _initialized = false;

  NotificationDefault() {
    initialize();
  }

  @override
  Future<void> initialize() async {
    if (!html.Notification.supported) {
      throw Exception('[notification] 该浏览器不支持通知功能');
    }

    final permission = await html.Notification.requestPermission();
    _initialized = permission == 'granted';

    if (!_initialized) {
      throw Exception('[notification] Web通知权限被拒绝');
    }

    debugPrint('[notification] Web通知初始化成功');
  }

  @override
  Future<void> show({required String title, required String body}) async {
    if (!_initialized) {
      throw Exception('[notification] 通知未初始化，请先调用 initialize()');
    }

    html.Notification(
      title,
      body: body,
      icon: 'assets/images/ic_push.png', // 可选：设置通知图标
    );
  }
}
