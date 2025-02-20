// 角色管理 类型
// 角色管理类型
class RolePower {
  int attachSizeLimit = 0;
  int batchPersonLimit = 0;
  int boardAce = 0;
  int msgAce = 0;
  int orderSystem = 0;
  int profileEdit = 0;
  int profileView = 0;
}

// 服务器信息
class ServerMapInfo {
  String serverType = '';
  String loginServer = '';
  String webServer = '';
  String fileServer = '';
  String mediaServer = '';

  ServerMapInfo({
    required this.serverType,
    required this.loginServer,
    required this.webServer,
    required this.fileServer,
    required this.mediaServer,
  });

  factory ServerMapInfo.fromJson(Map<String, dynamic> json) {
    return ServerMapInfo(
      serverType: json['server_type'] ?? '',
      loginServer: json['login_server'] ?? '',
      webServer: json['web_server'] ?? '',
      fileServer: json['file_server'] ?? '',
      mediaServer: json['media_server'] ?? '',
    );
  }
}
