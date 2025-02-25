import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:core/domain/dao/entity/entity.dart';
import 'package:core/domain/dao/repository/repository.dart';
import 'package:core/domain/dao/sql/sql.dart';
import 'package:core/platform/database/db_manage.dart';

void main() {
  group('DbRepository', () {
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
      await File(dbPath).delete();
    });

    test('test', () async {
      final options = OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          debugPrint('onCreate $version');

          // 创建测试表
          await db.execute(sql_v1);
        },
      );

      // 执行初始化
      await dbManager.initialize(dbPath, dbName, options);

      final config = Config(
        configId: 1,
        configKey: 'test',
        configValue: 'test',
      );

      await ConfigRepository().insert(config);

      config.configValue = 'test2';
      await ConfigRepository().update(config);

      debugPrint("config ${config.toMap()}");

      final config2 = await ConfigRepository().findById(Config(configId: 1));
      expect(config2, isNotNull);
      expect(config2!.configId, 1);
      expect(config2.configKey, 'test');
      expect(config2.configValue, 'test2');

      final config3 = await ConfigRepository().findAll(config);
      expect(config3, isNotNull);
      expect(config3.length, 1);
      expect(config3[0].configId, 1);
      expect(config3[0].configKey, 'test');
      expect(config3[0].configValue, 'test2');

      await ConfigRepository().delete(config);

      // 测试 addOrUpdate 方法
      final configForAddOrUpdate = Config(
        configId: 2,
        configKey: 'test_add_or_update',
        configValue: 'initial_value',
      );

      // 测试添加新记录
      await ConfigRepository().addOrUpdate(configForAddOrUpdate);
      var result = await ConfigRepository().findById(Config(configId: 2));
      expect(result, isNotNull);
      expect(result!.configValue, 'initial_value');

      // 测试更新现有记录
      final configForAddOrUpdate2 = Config(
        configId: 2,
        configKey: '',
        configValue: 'updated_value',
      );

      await ConfigRepository().addOrUpdate(configForAddOrUpdate2);
      result = await ConfigRepository().findById(Config(configId: 2));
      expect(result, isNotNull);
      expect(result!.configKey, '');
      expect(result!.configValue, 'updated_value');
    });
  });
}
