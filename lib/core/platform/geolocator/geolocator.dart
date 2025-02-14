import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../exceptions/permission_exception.dart';

class GeolocatorPlatform {
  static final GeolocatorPlatform instance = GeolocatorPlatform._();

  GeolocatorPlatform._();

  Future<Position> getCurrentPosition() async {
    await _isAllow();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
      forceAndroidLocationManager: true, // 国内没有谷歌服务,强制使用设备定位
      timeLimit: const Duration(seconds: 3),
    );
    return position;
  }

  Future<Position?> getLastKnownPosition() async {
    await _isAllow();
    return await Geolocator.getLastKnownPosition();
  }

  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> _isAllow() async {
    final isEnabled = await isLocationServiceEnabled();
    if (!isEnabled) {
      throw PermissionException('位置服务未开启');
    }

    final permission = await checkPermission();
    final res = (permission == LocationPermission.always) ||
        (permission == LocationPermission.whileInUse);

    if (!res) {
      throw PermissionException('位置权限未开启');
    }

    return true;
  }
}
