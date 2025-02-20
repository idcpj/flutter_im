import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static Future<void> initializeDatabase() async {
    if (_database != null) return;


    DatabaseFactory databaseFactory;

    String dbPath = 'im_database.db';
    try {
      if (kIsWeb) {
        // Web平台初始化
        databaseFactory = databaseFactoryFfiWeb;
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // 其他平台初始化
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      } else if (Platform.isAndroid || Platform.isIOS) {
        databaseFactory = sqflite.databaseFactory;
      } else {
        throw UnsupportedError('不支持的平台: ${Platform.operatingSystem}');
      }

      dbPath = join(await databaseFactory.getDatabasesPath(), dbPath);
      debugPrint('数据库路径: $dbPath');

      _database = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) => _createDB(db, version),
        ),
      );
    } catch (e) {
      print('数据库初始化失败: $e');
      rethrow;
    }
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS people (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL
      )
    ''');
    print('数据库表创建成功');
  }

  Future<int> createPerson(String name, int age) async {
    _checkInitialized();

    final data = {'name': name, 'age': age};
    final id = await _database!.insert('people', data);
    print('创建人员成功 ID: $id');
    return id;
  }

  Future<List<Map<String, dynamic>>> getAllPeople() async {
    _checkInitialized();

    final result = await _database!.query('people');
    print('获取到 ${result.length} 条人员数据');
    return result;
  }

  void _checkInitialized() {
    if (_database == null) {
      throw Exception('数据库未初始化，请先调用 initializeDatabase()');
    }
  }

  // 新增关闭数据库方法
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      print('数据库已关闭');
    }
  }
}
