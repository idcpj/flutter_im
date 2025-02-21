import 'config_interface.dart';

class AppConfigWeb extends AppConfigAbstract {
  // web 数据库不需要那么多路径
  @override
  getDbPath() {
    return '$saasId';
  }

  @override
  getDbName() {
    return "$userId.db";
  }
}
