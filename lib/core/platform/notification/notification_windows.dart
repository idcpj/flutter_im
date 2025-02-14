import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications_windows/flutter_local_notifications_windows.dart';
import '../../exceptions/initialize_exception.dart';
import 'notification_interface.dart';

class NotificationWindows implements NotificationAbstract {
  final _notifications = FlutterLocalNotificationsWindows();
  bool _initialized = false;

  NotificationWindows() {
    initialize();
  }

  Future<void> initialize() async {
    const settings = WindowsInitializationSettings(
      appName: 'test',
      appUserModelId: 'com.test.test',
      guid: 'a8c22b55-049e-422f-b30f-863694de08c8',
    );

    final res = await _notifications.initialize(settings);
    if (res == false) throw InitializeException('Windows通知初始化失败');

    debugPrint('[notification] Windows通知初始化成功');
    _initialized = true;
  }

  @override
  Future<void> show({required String title, required String body}) async {
    if (!_initialized) {
      throw InitializeException('[notification] 通知未初始化，请先调用 initialize()');
    }

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
