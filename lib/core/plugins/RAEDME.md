# 平台最佳实践
```
notification/
├── notification.dart              # 条件导出
├── notification_platform_interface.dart  # 接口定义
├── notification_method_channel.dart      # 默认实现
├── notification_web.dart      # Web 实现
└── notification_windows.dart      # Windows 实现
```



所有的平台判断
```
export 'notification_method_channel.dart' // 默认
    if (dart.library.html) 'notification_web.dart' // Web
    if (dart.library.windows) 'notification_windows.dart' // Windows
    if (dart.library.io) 'notification_method_channel.dart' // Android/iOS
    if (dart.library.macos) 'notification_macos.dart' // macOS
    if (dart.library.linux) 'notification_linux.dart'; // Linux
```