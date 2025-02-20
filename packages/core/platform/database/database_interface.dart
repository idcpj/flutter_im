import 'package:sqflite/sqflite.dart';

import '../../config/config.dart';

abstract class DbAbstract {
  DatabaseFactory? dbFactory;
  Database? database;
  DbConfig? conf;

  int latestVersion = 1; // 更新数据库版本号
}
