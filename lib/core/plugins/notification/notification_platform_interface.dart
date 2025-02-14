import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'notification_method_channel.dart';

abstract class NotificationPlatform extends PlatformInterface {
  NotificationPlatform() : super(token: _token);
  static final Object _token = Object();
  static NotificationPlatform _instance = MethodChannelNotification(); // 使用默认实现

  static NotificationPlatform get instance => _instance;

  static set instance(NotificationPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // 具体实现
  Future<void> initialize();
  Future<void> show({required String title, required String body});
}
