import 'package:sqflite/sqlite_api.dart';

import '../../config/config_interface.dart';

abstract class DbAbstract {
  DatabaseFactory? dbFactory;
  Database? database;
}
