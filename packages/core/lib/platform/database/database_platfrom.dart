import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_interface.dart';

class DbPlatfrom extends DbAbstract {
  DbPlatfrom() {
    // 其他平台初始化
    sqfliteFfiInit();
    dbFactory = databaseFactoryFfi;
  }
}
