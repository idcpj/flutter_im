part of 'types.dart';

abstract class AppAbstract {
  // 初始化
  Future<void> initialize();

  // 连接服务器
  void connect();

  // 断开连接
  void disconnect();

  // 事件总线
  EventBusAbstract get eventBus;

  // 发送消息
  send(Message data);

  void listen(CmdCode name, CmdCallback callback);

  bool isLogin();

  String userName();

  String userId();

  String saasId();

  String getVersion();

  Future<void> afterLogin(Message data);

  DbService get dbService;

  LogAbstract get log;

  UserService get userService;

  AppConfigAbstract get config;

  ConfigService get configService;

  SystemService get systemService;
}
