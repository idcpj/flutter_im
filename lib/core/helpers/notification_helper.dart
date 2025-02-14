import 'package:flutter_im/core/plugins/notification/notification_platform_interface.dart';
import 'package:flutter_im/core/plugins/notification/notification.dart';

class NotificationHelper {
  static final NotificationHelper instance = NotificationHelper._();
  final _platform = NotificationPlatform.instance;

  NotificationHelper._();

  Future<void> initialize() => _platform.initialize();

  Future<void> show({required String title, required String body}) =>
      _platform.show(title: title, body: body);
}
