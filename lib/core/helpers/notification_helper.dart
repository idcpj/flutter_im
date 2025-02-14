import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_windows/flutter_local_notifications_windows.dart';

class NotificationHelper {
  static final NotificationHelper instance = NotificationHelper._init();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final flutterLocalNotificationsWindows = FlutterLocalNotificationsWindows();

  NotificationHelper._init();

  // 初始化
  Future<void> initialize() async {
    await initWindwos();
    await initOther();
  }

  Future<void> initWindwos() async {
    const WindowsInitializationSettings settings =
        WindowsInitializationSettings(
      appName: 'test',
      appUserModelId: 'com.test.test',
      guid: 'a8c22b55-049e-422f-b30f-863694de08c8',
    );

    final res = await flutterLocalNotificationsWindows.initialize(settings);
    if (res == false) {
      debugPrint('[notification] 初始化失败');
      throw Exception('初始化失败');
    }
  }

  Future<void> initOther() async {
    // 设置初始化设置
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_push");

    var ios = const DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: ios,
    );

    final res = await flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse details) async {
      debugPrint('[notification] 收到后台通知: $details');
    });

    if (res == false) {
      debugPrint('[notification] 初始化失败');
      throw Exception('初始化失败');
    }
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    if (Platform.isWindows) {
      await flutterLocalNotificationsWindows.show(
        1,
        title,
        body,
        details: WindowsNotificationDetails(
          subtitle: 'subtitle',
          images: [
            // WindowsImage(
            //   WindowsImage.getAssetUri('assets/images/ic_push.png'),
            //   altText: 'altText',
            //   crop: WindowsImageCrop.circle,
            // ),
          ],
        ),
      );
    } else {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: '默认通道描述',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      await flutterLocalNotificationsPlugin.show(
        1,
        title,
        body,
        const NotificationDetails(
          android: androidNotificationDetails,
        ),
      );
    }
  }
}
