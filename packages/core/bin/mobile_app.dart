import 'package:package_info_plus/package_info_plus.dart';

import '../config/config.dart';
import '../constants/constants.dart';
import '../domain/services/config_service.dart';
import '../domain/services/user_service.dart';
import '../helpers/event.dart';
import '../io/tcp.dart';
import '../platform/log/log.dart';
import '../types/types.dart';

class MobileApp implements AppAbstract {
  AppConfig _config;
  LogAbstract? _log;
  SocketAbstract? _socket;

  EventBusAbstract? _eventBus;

  UserService? _userService;
  ConfigService? _configService;

  MobileApp({
    required AppConfig config,
  }) : _config = config {
    // 初始化日志
    _log = LogPlatform(path: config.log.path);

    // 初始化事件总线
    _eventBus = EventBus();

    // 初始化 socket
    _socket = TcpClient(log: _log!);
    _socket!.bind((data) {
      final message = Message.fromBytes(data);
      _eventBus?.emit(message.header.cmd, message);
    });

    // 初始化服务
    _userService = UserService(app: this);
    _configService = ConfigService(app: this);
  }

  Future<void> connect() async {
    await _socket?.connect(_config.net.host, _config.net.port);
  }

  disconnect() {
    _socket?.disconnect();
  }

  @override
  EventBusAbstract get eventBus => _eventBus!;

  @override
  Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  bool isLogin() {
    return false;
  }

  @override
  void listen(CmdCode name, CmdCallback callback) {
    _eventBus?.on(name).listen((message) {
      callback(message.header.code, message);
    });
  }

  @override
  String saasId() {
    throw UnimplementedError("saasId");
  }

  @override
  send(Message data) {
    _socket?.send(data.toBytes());
  }

  @override
  String userId() {
    throw UnimplementedError("userId");
  }

  @override
  String userName() {
    throw UnimplementedError("userName");
  }

  @override
  UserService get userService => _userService!;

  @override
  AppConfig get config => _config;
}
