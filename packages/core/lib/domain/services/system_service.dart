import 'package:core/constants/constants.dart';

import 'base_service.dart';

class SystemService extends BaseService {
  SystemService({required super.app});

  int errCount = 0;

  void cmdHeart() {
    // 通过控制浏览器的 网络选项的切换离线,可模拟连接失败
    errCount = 0;
    Future.delayed(const Duration(seconds: 30), () {
      final msg = buildMessage(CmdCode.sysClientCheckLive);
      send(msg);
      errCount++;
      app.log.debug("心跳失败次数: $errCount");
      if (errCount > 3) {
        return;
        // this.client.UserService().cmd_relogin();
      }
      cmdHeart(); // 重新调用心跳
    });

    app.listen(CmdCode.sysClientCheckLive, (code, data) {
      errCount = 0;
      app.log.debug("心跳成功");
      return Future.value();
    });
  }
}
