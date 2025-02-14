import 'notification_default.dart'
    if (dart.library.html) 'notification_web.dart';

import 'notification_windows.dart';

import 'notification_interface.dart';
import "../../utils/platform.dart";

class NotificationPlatform {
  late NotificationAbstract _platform;

// 私有构造函数
  static final NotificationPlatform instance = NotificationPlatform._();
  NotificationPlatform._();

  Future<void> initialize() async {
    if (Platform.isWeb) {
      _platform = NotificationDefault();
    } else if (Platform.isWindows) {
      _platform = NotificationWindows();
    } else {
      _platform = NotificationDefault();
    }
  }

  Future<void> show({required String title, required String body}) =>
      _platform.show(title: title, body: body);
}
