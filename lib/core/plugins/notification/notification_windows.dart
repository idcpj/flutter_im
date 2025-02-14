import 'package:flutter_local_notifications_windows/flutter_local_notifications_windows.dart';
import 'notification_platform_interface.dart';

class WindowsNotification extends NotificationPlatform {
  final _notifications = FlutterLocalNotificationsWindows();

  @override
  Future<void> initialize() async {
    const settings = WindowsInitializationSettings(
      appName: 'test',
      appUserModelId: 'com.test.test',
      guid: 'a8c22b55-049e-422f-b30f-863694de08c8',
    );

    final res = await _notifications.initialize(settings);
    if (res == false) throw Exception('Windows通知初始化失败');
  }

  @override
  Future<void> show({required String title, required String body}) async {
    await _notifications.show(
      1,
      title,
      body,
      details: WindowsNotificationDetails(
        subtitle: '',
        images: [],
      ),
    );
  }
}
