import 'package:core/types/types.dart';

abstract class AppConfigAbstract {
  String project = "FIMPro";
  LogLevel logLevel = LogLevel.all;

  // 数据库版本
  // 每次更新数据库结构,版本都加1
  int latestVersion = 1;

  // 文档目录
  String? documentPath;

  // saas_id
  String? saasId;
  // 用户id
  String? userId;

  String? host;
  int? port;
  String? domain;

  // 构建时间
  String buildTime = DateTime.now().toIso8601String();

  String? version;

  void initialize(String documentPath, int latestVersion, String version) {
    this.documentPath = documentPath;
    this.latestVersion = latestVersion;
    this.version = version;
  }

  setSaasId(String id) {
    saasId = id;
  }

  setUserId(String id) {
    userId = id;
  }

  setNetConfig(String host, int port, String domain) {
    this.host = host;
    this.port = port;
    this.domain = domain;
  }

  getBrandImage() {
    return '$documentPath/FIMPro/Data/$saasId/BrandImage';
  }

  getPluginImage() {
    return '$documentPath/FIMPro/Data/$saasId/PluginImage';
  }

  getUserHeadPath() {
    return '$documentPath/FIMPro/Data/$saasId/UserHead';
  }

  getPluginUser() {
    return '$documentPath/FIMPro/Data/$saasId/User/$userId';
  }

  getDbPath() {
    return '$documentPath/FIMPro/Data/$saasId/User/$userId';
  }

  getDbName() {
    return 'data.db';
  }

  //表情包路径
  getExpression() {
    return '$documentPath/FIMPro/Data/$saasId/Expression/$userId';
  }

  getMeditPath() {
    return '$documentPath/FIMPro/Data';
  }

  getLogPath() {
    return '$documentPath/FIMPro/Log';
  }

  getVersion() {
    return version;
  }
}
