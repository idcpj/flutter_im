import '../../../types/orm.dart';

class Config implements Table {
  String get tableName => 'hs_config';
  Field get primaryKey => const Field(name: 'config_id', type: FieldType.int, isPrimary: true);

  int? configId;
  String configKey;
  String configValue;
  String configType; //   // type="login_info" 登录时候返回的信息

  Config({
    this.configId,
    this.configKey = '',
    this.configValue = '',
    this.configType = '',
  });

  List<Field> get fields => [
        const Field(name: 'config_id', type: FieldType.int, isPrimary: true),
        const Field(name: 'config_key', type: FieldType.string),
        const Field(name: 'config_value', type: FieldType.string),
        const Field(name: 'config_type', type: FieldType.string),
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'config_id': configId,
      'config_key': configKey,
      'config_value': configValue,
      'config_type': configType,
    };
  }

  @override
  Config fromMap(Map<String, dynamic> map) {
    return Config(
      configId: map['config_id'],
      configKey: map['config_key'],
      configValue: map['config_value'],
      configType: map['config_type'],
    );
  }
}
