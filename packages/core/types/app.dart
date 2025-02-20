import '../config/config.dart';
import '../domain/services/config_service.dart';
import '../domain/services/user_service.dart';
import 'types.dart';

abstract class AppAbstract {
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

  Future<String> getVersion();

  UserService get userService;
  AppConfig get config;
  ConfigService get configService;
}
