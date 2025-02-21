import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../exceptions/exceptions.dart';
import 'notification_interface.dart';

class NotificationDefault implements NotificationAbstract {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  NotificationDefault() {
    initialize();
  }

  Future<void> initialize() async {
    // 移动端配置
    const settingsAndroid = AndroidInitializationSettings('@mipmap/ic_push');

    // 苹果端配置
    const settingsDarwin = DarwinInitializationSettings();

    // Linux端配置
    final settingsLinux = LinuxInitializationSettings(
      defaultActionName: 'defaultActionName',
      defaultIcon: AssetsLinuxIcon("assets/images/ic_push.png"),
      defaultSound: AssetsLinuxSound("assets/sounds/slow_spring_board.mp3"),
    );

    // 初始化
    final initializationSettings = InitializationSettings(
      android: settingsAndroid,
      iOS: settingsDarwin,
      linux: settingsLinux,
    );

    final res = await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _handleBackgroundNotification,
    );

    if (res == false) {
      throw InitializeException('[notification] 移动端初始化失败');
    }

    debugPrint("[notification] 移动端初始化成功");
    _initialized = true;
  }

  static void _handleBackgroundNotification(NotificationResponse details) {
    debugPrint('[notification] 移动端收到后台通知: $details');
  }

  @override
  Future<void> show({required String title, required String body}) async {
    if (!_initialized) {
      throw InitializeException('[notification] 通知未初始化，请先调用 initialize()');
    }

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
