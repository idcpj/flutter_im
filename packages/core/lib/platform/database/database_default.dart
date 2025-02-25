import 'package:sqflite/sqflite.dart';

import 'database_interface.dart';

class DbDefault extends DbAbstract {
  DbDefault() {
    dbFactory = databaseFactory;
  }
}
