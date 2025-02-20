import 'package:device_info_plus/device_info_plus.dart';

import '../../helpers/platform.dart';

class DeviceInfo {
  static Future<String> macAddr() async {
    if (!Platform.isDesktop) return '';

    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      return info.computerName;
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return info.systemGUID ?? '';
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return info.machineId ?? '';
    }
    return '';
  }

  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // 安卓设备ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? ''; // iOS设备ID
    }
    return '';
  }
}
