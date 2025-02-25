import 'package:flutter/foundation.dart';

import 'package:core/constants/constants.dart';
import 'package:core/helpers/parse_xml.dart';
import 'package:core/helpers/time.dart';
import 'package:core/types/types.dart';
import 'package:core/domain/dao/entity/entity.dart';
import 'package:core/domain/dao/repository/repository.dart';
import 'package:core/domain/hook/base_hook.dart';

class UserHook extends BaseHook {
  UserHook(super.app) {
    app.listen(CmdCode.login, login);
    debugPrint('[UserHook]  初始化');
  }

  Future<void> login(StaticCode code, Message data) async {
    //错误在页面中抛出
    if (!checkCodeNotException(code)) {
      return Future.value();
    }
    // 登录后进行初始化
    await app.afterLogin(data);

    debugPrint('[UserHook]  登录成功 $data');

    final userId = data.params[0];
    final saasid = data.params[1];

    String getPropsKey(LoginResKey key) {
      return data.props[key.value] != null ? Uri.decodeComponent(data.props[key.value]!) : "";
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

    CacheRepository.setCache(LoginResKey.stime.value, timeFormat(DateTime.now(), format: 'yyyy-MM-dd HH:mm:ss'));

    CacheRepository.setCache(LoginResKey.userId.value, user.userId);
    CacheRepository.setCache(LoginResKey.ssid.value, user.userSsid);
    CacheRepository.setCache(LoginResKey.userLogin.value, user.userLogin);
    CacheRepository.setCache(LoginResKey.userName.value, user.userName);

    CacheRepository.setCache(LoginResKey.needChangePwd.value, data.params[8]);

    handleRolePower(getPropsKey(LoginResKey.roleacexml));

    return Future.value();
  }

  void handleRolePower(String roleXml) {
    final rolePower = parseRoleXml(roleXml);
    CacheRepository.setCache(LoginResKey.roleacexml.value, rolePower);
  }
}
