import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_platform_interface.dart';

class MethodChannelNotification extends NotificationPlatform {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_push');
    const initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    final res = await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _handleBackgroundNotification,
    );

    if (res == false) {
      throw Exception('[notification] 初始化失败');
    }
  }

  void _handleBackgroundNotification(NotificationResponse details) {
    debugPrint('[notification] 收到后台通知: $details');
  }

  @override
  Future<void> show({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: '默认通道描述',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    await _flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      const NotificationDetails(android: androidDetails),
    );
  }
}
