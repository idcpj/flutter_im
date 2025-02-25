import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:core/config/config.dart';
import 'package:core/constants/constants.dart';
import 'package:core/domain/services/config_service.dart';
import 'package:core/domain/services/db_service.dart';
import 'package:core/domain/services/system_service.dart';
import 'package:core/domain/services/user_service.dart';
import 'package:core/helpers/event.dart';
import 'package:core/io/tcp_client.dart';
import 'package:core/platform/log/log.dart';
import 'package:core/types/types.dart';

class MobileApp implements AppAbstract {
  AppConfigAbstract? _config;
  LogAbstract? _log;
  SocketAbstract? _socket;

  EventBusAbstract? _eventBus;

  UserService? _userService;
  ConfigService? _configService;
  DbService? _dbService;
  SystemService? _systemService;

  MobileApp() {
    //config
    _config = Config().config;

    // 初始化日志
    _log = LogPlatform();

    // 初始化事件总线
    _eventBus = EventBus(_log);

    // 初始化 socket
    _socket = TcpClient(log: _log!);

    // 初始化服务
    _userService = UserService(app: this);
    _configService = ConfigService(app: this);
    _dbService = DbService(app: this);
  }

  @override
  Future<void> initialize() async {
    // 配置文件初始化
    final path = await getApplicationDocumentsDirectory();

    final packageInfo = await PackageInfo.fromPlatform();

    _config!.initialize(path.path, _config!.latestVersion, packageInfo.version);

    _log!.initialization(config.getLogPath(), _config!.logLevel);

    //
    _socket!.bind((data) {
      final message = Message.fromBytes(data);
      _eventBus?.emit(message.header.cmd, message);
    });
  }

  @override
  Future<void> connect({String? host, int? port, String? domain}) async {
    // 第一次初始化
    if (host != null && port != null && domain != null) {
      _config!.setNetConfig(host, port, domain);
    }

    await _socket?.connect(host!, port!);
  }

  @override
  Future<void> afterLogin(Message data) async {
    final userId = data.params[0];
    final saasid = data.params[1];

    _config!.setSaasId(saasid);
    _config!.setUserId(userId);

    _log!.debug('[app] 初始化数据库');
    await _dbService!.initAfterLogin();

    //  登录成功后触发心跳
    _systemService!.cmdHeart();
    _log!.debug('[app] 触发心跳');
  }

  @override
  disconnect() {
    _socket?.disconnect();
  }

  @override
  EventBusAbstract get eventBus => _eventBus!;

  @override
  String getVersion() {
    return _config!.getVersion();
  }

  @override
  bool isLogin() {
    return false;
  }

  @override
  void listen(CmdCode name, CmdCallback callback) {
    _eventBus?.on(name).listen((Message message) async {
      await callback(message.header.status, message);
    });
  }

  @override
  String saasId() {
    return _configService!.saasId();
  }

  @override
  send(Message data) {
    _socket?.send(data.toBytes());
  }

  @override
  String userId() {
    return _configService!.userId();
  }

  @override
  String userName() {
    return _configService!.userName();
  }

  @override
  UserService get userService => _userService!;

  @override
  AppConfigAbstract get config => _config!;

  @override
  ConfigService get configService => _configService!;

  @override
  DbService get dbService => _dbService!;

  @override
  LogAbstract get log => _log!;

  @override
  SystemService get systemService => _systemService!;
}
