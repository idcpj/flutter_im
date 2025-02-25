import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'package:core/platform/database/db_manage.dart';

void main() {
  group('DbManage Tests', () {
    late DbManage dbManager;

    const dbPath = 'test_db_path';
    const dbName = 'test4.db';

    setUp(() {
      // 在setUp中设置平台
      TestWidgetsFlutterBinding.ensureInitialized();
      // 模拟 Windows 平台
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;

      dbManager = DbManage();
    });

    tearDown(() async {
      final dbPath = dbManager.db.database!.path;
      // 确保每个测试后关闭数据库
      await dbManager.close();
      // 删除数据库
      final file = await File(dbPath).delete();
    });

    test('测试数据库', () async {
      final options = OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          debugPrint('onCreate $version');

          // 创建测试表
          await db.execute(
            'CREATE TABLE IF NOT EXISTS test_table (id INTEGER PRIMARY KEY, name TEXT)',
          );
        },
      );

      // 执行初始化
      await dbManager.initialize(dbPath, dbName, options);

      // 验证数据库是否正确初始化
      expect(dbManager, isNotNull);

      // 插入数据
      await dbManager.db.database!.insert('test_table', {'id': 1, 'name': 'test'});

      // 获取数据
      final data = await dbManager.db.database!.rawQuery('SELECT * FROM test_table');
      expect(data, isNotNull);
      expect(data.length, 1);
      expect(data[0]['name'], 'test');

      // 验证数据库版本
      final version = await dbManager.db.database!.getVersion();
      expect(version, 1);

      await dbManager.close();

      // 升级到版本2
      final optionsV2 = OpenDatabaseOptions(
          version: 2,
          onCreate: (db, version) async {
            debugPrint('onCreate $version');
            await db.execute("""
        CREATE TABLE IF NOT EXISTS test_table (id INTEGER PRIMARY KEY, name TEXT)
""");
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            debugPrint('onUpgrade $oldVersion $newVersion');
            if (oldVersion == 1) {
              // 版本1到版本2的迁移逻辑
              await db.execute('ALTER TABLE test_table ADD COLUMN value TEXT DEFAULT "" ');
            }
          });

      expect(version, 1);

      // 重新打开数据库,此时会触发迁移
      await dbManager.initialize(dbPath, dbName, optionsV2);

      // 验证数据库版本
      final version1 = await dbManager.db.database!.getVersion();
      expect(version1, 2);

      // 验证数据是否迁移成功
      final dataV2 = await dbManager.db.database!.rawQuery('SELECT * FROM test_table');
      debugPrint('dataV2 $dataV2');
      expect(dataV2, isNotNull);
      expect(dataV2.length, 1);
      expect(dataV2[0]['name'], 'test');
      expect(dataV2[0]['value'], '');
    });
  });
}
