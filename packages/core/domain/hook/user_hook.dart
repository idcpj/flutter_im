import 'package:flutter/foundation.dart';

import '../../constants/constants.dart';
import '../../helpers/time.dart';
import '../../types/types.dart';
import '../dao/entity/entity.dart';
import '../dao/repository/cache_repository.dart';
import '../dao/repository/user_repository.dart';
import 'base_hook.dart';

class UserHook extends BaseHook {
  UserHook(super.app) {
    app.listen(CmdCode.login, login);
    debugPrint('[UserHook]  初始化');
  }

  Future<void> login(StaticCode code, Message data) {
    //错误在页面中抛出
    if (!checkCodeNotException(code)) {
      return Future.value();
    }
    // 初始化
    app.afterLogin(data);

    debugPrint('[UserHook]  登录成功 $data');

    final userId = data.params[0];
    final saasid = data.params[1];

    // 连接数据库

    //  登录成功后触发心跳
    // this.client.SystemService().cmd_heart();

    String getPropsKey(LoginResKey key) {
      return data.props[key.value] != null
          ? Uri.decodeComponent(data.props[key.value]!)
          : "";
    }

    const List<LoginResKey> saveKeys = [
      LoginResKey.accessToken,
      LoginResKey.appid,
      LoginResKey.appsecret,
      LoginResKey.cflag,
      LoginResKey.fileProtect,
      LoginResKey.hideUserJob,
      LoginResKey.msgEncrypt,
      LoginResKey.msgtoken,
      LoginResKey.orgIds,
      LoginResKey.p2pThreshold,
      LoginResKey.passwordStrength,
      LoginResKey.roleacexml,
      LoginResKey.roleIds,
      LoginResKey.sclen,
      LoginResKey.scname,
      LoginResKey.serverType,
      LoginResKey.servermapinfo,
      LoginResKey.serverTime,
      LoginResKey.slday,
      // LoginResKey.stime,  // 先不用服务器的时间,因为他时区不准,当前失去的格式为字符串
      LoginResKey.sver,
      LoginResKey.userDisableAcceptfile,
      LoginResKey.vertype,
      LoginResKey.webserver,
      LoginResKey.upic,
      LoginResKey.automaticOffline,
      LoginResKey.hideUserJob,
      LoginResKey.waringBt,
    ];

    saveKeys.map((item) {
      var val = getPropsKey(item);
      CacheRepository.setCache(item.value, val);
    });

    CacheRepository.setCache(LoginResKey.stime.value,
        timeFormat(DateTime.now(), format: 'yyyy-MM-dd HH:mm:ss'));

    // 添加人员
    final user = User(
      userId: userId,
      userSsid: data.params[1],
      userLogin: data.params[2],
      userName: data.params[3],
      userSessionId: data.params[4],
      userServerId: data.params[5],
      userPicture: getPropsKey(LoginResKey.upic),
    );

    UserRepository().addOrUpdate(user);

    // GlobalRepository.set_cache(USER_ID, user.user_id);
    // GlobalRepository.set_cache(SSID, user.user_ssid);
    // GlobalRepository.set_cache(USER_LOGIN, user.user_login);
    // GlobalRepository.set_cache(USER_NAME, user.user_name);

    // GlobalRepository.set_cache(NEED_CHANGE_PWD, data.params[8]);

    // this.handle_role_power(getPropsKey(ROLEACEXML))

    return Future.value();
  }
}
