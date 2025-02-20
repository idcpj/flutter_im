import 'package:flutter/foundation.dart';

import '../constants/constants.dart';

class Platform {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static bool get isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isMacOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  static bool get isWindows => !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  static bool get isLinux => !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  static bool get isFuchsia => !kIsWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  static bool get isMobile => isAndroid || isIOS;

  static bool get isDesktop => isWindows || isMacOS || isLinux;
}

class PlatformCode {
  static const Map<PlatformType, PlatformDesc> PlatformTypeMap = {
    PlatformType.unknown: PlatformDesc.unknown,
    PlatformType.win: PlatformDesc.win,
    PlatformType.mac: PlatformDesc.mac,
    PlatformType.qt: PlatformDesc.qt,
    PlatformType.ios: PlatformDesc.ios,
    PlatformType.android: PlatformDesc.android,
    PlatformType.web: PlatformDesc.web,
  };

  static PlatformDesc getCode(PlatformType platform) {
    return PlatformTypeMap[platform] ?? PlatformDesc.unknown;
  }
}
