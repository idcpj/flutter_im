import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'database_interface.dart';

class DbWeb extends DbAbstract {
  DbWeb() {
    dbFactory = databaseFactoryFfiWeb;
  }
}
