import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../config/config.dart';
import '../../helpers/platform.dart';
import 'database_default.dart';
import 'database_interface.dart';
import 'database_platfrom.dart';
import 'database_web.dart';

class DbManage {
  static final DbManage instance = DbManage._();
  DbManage._();

  static DbAbstract? _db;
  static DbConfig? _conf;

  static Future<void> initialize(DbConfig conf) async {
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

    _conf = conf;

    final dbPath = join(
        await _db!.dbFactory!.getDatabasesPath(), _conf!.path, _conf!.dbName);

    _db!.database = await _db!.dbFactory!.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: _db!.latestVersion,
        onCreate: (db, version) => _createDB(db, version),
        onUpgrade: (db, oldVersion, newVersion) =>
            _upgradeDB(db, oldVersion, newVersion),
        onDowngrade: onDatabaseDowngradeDelete, // 如果需要降级，则删除数据库重新创建
      ),
    );
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

  static Future<void> _upgradeDB(
      Database db, int oldVersion, int newVersion) async {
    print('开始数据库升级: $oldVersion -> $newVersion');

    // 使用事务来确保升级的原子性
    await db.transaction((txn) async {
      // 版本 1 到 2 的迁移
      if (oldVersion == 1) {
        // 为 people 表添加新列
        await txn.execute('ALTER TABLE people ADD COLUMN email TEXT');
        await txn.execute('ALTER TABLE people ADD COLUMN phone TEXT');

        // 创建新表
        await txn.execute('''
          CREATE TABLE IF NOT EXISTS user_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            action TEXT NOT NULL,
            created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
            FOREIGN KEY (user_id) REFERENCES people (id) ON DELETE CASCADE
          )
        ''');
      }

      // 版本 2 到 3 的迁移
      if (oldVersion <= 2 && newVersion >= 3) {
        // 添加未来版本的迁移代码
      }
    });

    print('数据库升级完成');
  }
}
