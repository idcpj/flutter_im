import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../helpers/platform.dart';
import 'database_default.dart';
import 'database_interface.dart';
import 'database_platfrom.dart';
import 'database_web.dart';

class DbManage {
  static final DbManage _instance = DbManage._();
  DbManage._();

  static DbAbstract? _db;

  DbAbstract get db => _db!;

  factory DbManage() {
    return _instance;
  }

  Future<void> initialize(String path, String dbName, OpenDatabaseOptions opts) async {
    if (Platform.isWeb) {
      // Web平台初始化
      _db = DbWeb();
    } else if (Platform.isDesktop) {
      _db = DbPlatfrom();
    } else if (Platform.isMobile) {
      _db = DbDefault();
    } else {
      throw UnsupportedError('不支持的平台: ${Platform.name} ');
    }

    final dbPath = join(path, dbName);

    debugPrint('[DbManage] $dbPath');
    _db!.database = await _db!.dbFactory!.openDatabase(
      dbPath,
      options: opts,
    );
  }

  Future<void> close() async {
    await _db!.database!.close();
    _db!.dbFactory = null;
    _db = null;
  }
}
