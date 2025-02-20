import 'package:local_notifier/local_notifier.dart';
import 'notification_interface.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NotificationWindows implements NotificationAbstract {
  NotificationWindows() {
    initialize();
  }

  Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    await localNotifier.setup(
      appName: packageInfo.appName,
      // 参数 shortcutPolicy 仅适用于 Windows
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  @override
  Future<void> show({required String title, required String body}) async {
    LocalNotification notification = LocalNotification(
      title: title,
      body: body,
    );
    notification.onShow = () {
      print('onShow ${notification.identifier}');
    };
    notification.onClose = (closeReason) {
      // 只支持在windows，其他平台 closeReason 始终为 unknown。
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
          // do something
          break;
        case LocalNotificationCloseReason.timedOut:
          // do something
          break;
        default:
      }
      print('onClose  - $closeReason');
    };
    notification.onClick = () {
      print('onClick ${notification.identifier}');
    };
    notification.onClickAction = (actionIndex) {
      print('onClickAction ${notification.identifier} - $actionIndex');
    };

    notification.show();
  }
}
