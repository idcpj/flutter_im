part of 'types.dart';

enum FieldType {
  int,
  bigint,
  string,
  text,
  timestamp,
  datetime,
}

// 字段定义
class Field {
  final String name;
  final FieldType type;
  final bool isPrimary;

  const Field({
    required this.name,
    required this.type,
    this.isPrimary = false,
  });
}

// 表的基类
abstract class Table {
  // 获取表名
  String get tableName;

  // 获取字段定义
  List<Field> get fields;

  // 获取主键字段
  Field get primaryKey => fields.firstWhere((field) => field.isPrimary);

  // 将Map转换为对象的方法
  Table fromMap(Map<String, dynamic> map);

  // 将对象转换为Map的方法
  Map<String, dynamic> toMap();
}
