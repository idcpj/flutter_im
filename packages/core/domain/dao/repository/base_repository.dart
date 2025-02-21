import 'package:sqflite/sqlite_api.dart';

import '../../../exceptions/exceptions.dart';
import '../../../platform/database/database_interface.dart';
import '../../../platform/database/db_manage.dart';
import '../../../types/types.dart';

class BaseRepository {
  final DbAbstract dbMange = DbManage().db;
  Database get db => dbMange.database!;

  Future<int> insert<T extends Table>(T item) async {
    return await db.insert(item.tableName, item.toMap());
  }

  Future<int> update<T extends Table>(T item) async {
    if (item.primaryKey.name.isEmpty) {
      throw ArgsException('[Repository] primaryKey is empty');
    }
    return await db.update(item.tableName, item.toMap(), where: '${item.primaryKey.name} = ?', whereArgs: [item.toMap()[item.primaryKey.name]]);
  }

  Future<int> delete<T extends Table>(T item) async {
    if (item.primaryKey.name.isEmpty) {
      throw ArgsException('[Repository] delete primaryKey is empty');
    }
    return await db.delete(item.tableName, where: '${item.primaryKey.name} = ?', whereArgs: [item.toMap()[item.primaryKey.name]]);
  }

  Future<List<T>> findAll<T extends Table>(T item) async {
    final data = await db.query(item.tableName);
    return data.map((Map<String, dynamic> e) => item.fromMap(e) as T).toList();
  }

  Future<T?> findById<T extends Table>(T item) async {
    if (item.primaryKey.name.isEmpty) {
      throw ArgsException('[Repository] findById primaryKey is empty ${item.tableName}');
    }
    final data = await db.query(item.tableName, where: '${item.primaryKey.name} = ?', whereArgs: [item.toMap()[item.primaryKey.name]]);
    if (data.isEmpty) {
      throw ArgsException('[Repository] findById data is empty ${item.tableName}');
    }
    return item.fromMap(data.first) as T;
  }
}
