import '../helpers/platform.dart';
import 'configMobile.dart';
import 'configPlatform.dart';
import 'configWeb.dart';
import 'config_interface.dart';

export 'config_interface.dart';
export 'configMobile.dart';

class Config {
  static late AppConfigAbstract _config;

  get config => _config;

  Config() {
    if (Platform.isWeb) {
      _config = AppConfigWeb();
    } else if (Platform.isMobile) {
      _config = AppConfigMobile();
    } else if (Platform.isDesktop) {
      _config = AppConfigPlatform();
    } else {
      throw Exception('Unsupported platform');
    }
  }
}
