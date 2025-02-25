import 'package:sqflite/sqlite_api.dart';

import 'package:core/platform/database/db_manage.dart';
import 'package:core/types/types.dart';
import 'package:core/domain/dao/sql/sql.dart';

/// 对数据库进行初始化等处理
class DbService {
  AppAbstract app;
  LogAbstract log;
  final DbManage _dbManage = DbManage();

  DbService({required this.app}) : log = app.log;

  //  需要登录客户端连接成功后再触发
  Future<void> initAfterLogin() async {
    final ops = OpenDatabaseOptions(
      version: app.config.latestVersion,
      onCreate: (db, version) => _createDB(db, version),
      onUpgrade: (db, oldVersion, newVersion) => _upgradeDB(db, oldVersion, newVersion),
      // onDowngrade: onDatabaseDowngradeDelete, // 如果需要降级，则删除数据库重新创建
    );

    await _dbManage.initialize(
      app.config.getDbPath(),
      app.config.getDbName(),
      ops,
    );

    app.log.info('[DbService] 初始化');
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(sql_v1);
    log.info('[DbService] 数据库表创建成功');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    log.info('[DbService] 开始数据库升级: $oldVersion -> $newVersion');

    // 使用事务来确保升级的原子性
    await db.transaction((txn) async {
      // 版本 1 到 2 的迁移
      if (oldVersion == 1) {
        // 为 people 表添加新列
        // await txn.execute('ALTER TABLE people ADD COLUMN email TEXT');
        // await txn.execute('ALTER TABLE people ADD COLUMN phone TEXT');

        // 创建新表
        // await txn.execute('''
        //   CREATE TABLE IF NOT EXISTS user_logs (
        //     id INTEGER PRIMARY KEY AUTOINCREMENT,
        //     user_id INTEGER NOT NULL,
        //     action TEXT NOT NULL,
        //     created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
        //     FOREIGN KEY (user_id) REFERENCES people (id) ON DELETE CASCADE
        //   )
        // ''');
      }

      // 版本 2 到 3 的迁移
      if (oldVersion <= 2 && newVersion >= 3) {
        // 添加未来版本的迁移代码
      }
    });

    log.info('[DbService] 数据库升级完成');
  }

  Future<void> close() async {
    log.info('[DbService] 关闭数据库');
    await _dbManage.close();
  }
}
