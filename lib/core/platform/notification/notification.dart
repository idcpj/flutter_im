import 'dart:io' show Platform;

import 'package:flutter_im/core/platform/notification/notification_interface.dart';

import 'notification_channel.dart';
// import 'notification_linux.dart.del';
import 'notification_windows.dart';

class NotificationPlatform {
  late NotificationAbstract _platform;

// 私有构造函数
  static final NotificationPlatform instance = NotificationPlatform._();
  NotificationPlatform._();

  Future<void> initialize() async {
    if (Platform.isWindows) {
      _platform = NotificationWindows();
    } else if (Platform.isLinux) {
      // _platform = NotificationLinux();
    } else {
      _platform = NotificationDefault();
    }
    await _platform.initialize();
  }

  Future<void> show({required String title, required String body}) =>
      _platform.show(title: title, body: body);
}
