import 'package:sqflite/sqlite_api.dart';

abstract class DbAbstract {
  DatabaseFactory? dbFactory;
  Database? database;
}
