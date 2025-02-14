import 'package:flutter/foundation.dart';
import 'notification_channel.dart';
import 'notification_windows.dart';
import 'notification_web.dart';
import 'notification_interface.dart';

class NotificationPlatform {
  late NotificationAbstract _platform;

// 私有构造函数
  static final NotificationPlatform instance = NotificationPlatform._();
  NotificationPlatform._();

  Future<void> initialize() async {
    if (kIsWeb) {
      _platform = NotificationWeb();
    } else {
      // 在非 web 平台上才导入 dart:io
      if (defaultTargetPlatform == TargetPlatform.windows) {
        _platform = NotificationWindows();
      } else {
        _platform = NotificationDefault();
      }
    }

    await _platform.initialize();
  }

  Future<void> show({required String title, required String body}) =>
      _platform.show(title: title, body: body);
}
