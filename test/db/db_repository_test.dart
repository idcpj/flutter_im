import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../packages/core/domain/dao/entity/entity.dart';
import '../../packages/core/domain/dao/repository/base_repository.dart';
import '../../packages/core/platform/database/db_manage.dart';

class ConfigRepository extends BaseRepository {
  ConfigRepository();

  // Future<void> insertConfig(Config config) async {
  //   await insert(config);
  // }
}

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
          await db.execute("""
CREATE TABLE IF NOT EXISTS hs_config (
  config_id INTEGER PRIMARY KEY ,
  config_key TEXT DEFAULT '',
  config_value TEXT DEFAULT '',
  config_type TEXT DEFAULT ''
)          """);
        },
      );

      // 执行初始化
      await dbManager.initialize(dbPath, dbName, options);

      final configRepository = ConfigRepository();

      final config = Config(
        configId: 1,
        configKey: 'test',
        configValue: 'test',
      );
      await configRepository.insert(config);

      config.configValue = 'test2';
      await configRepository.update(config);

      debugPrint("config ${config.toMap()}");

      final config2 = await configRepository.findById(Config(configId: 1));
      expect(config2, isNotNull);
      expect(config2!.configId, 1);
      expect(config2.configKey, 'test');
      expect(config2.configValue, 'test2');

      final config3 = await configRepository.findAll(config);
      expect(config3, isNotNull);
      expect(config3.length, 1);
      expect(config3[0].configId, 1);
      expect(config3[0].configKey, 'test');
      expect(config3[0].configValue, 'test2');

      await configRepository.delete(config);
    });
  });
}
