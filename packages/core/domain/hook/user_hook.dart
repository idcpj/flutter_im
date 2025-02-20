import 'package:flutter/foundation.dart';

import '../../constants/constants.dart';
import '../../types/types.dart';
import 'base_hook.dart';

class UserHook extends BaseHook {
  UserHook(super.app) {
    debugPrint('[UserHook]  初始化');
    app.listen(CMD_LOGIN, login);
  }

  void login(int code, Message data) {
    //错误在页面中抛出
    if (!checkCodeNotException(code)) {
      return;
    }

    final userId = data.params[0];
    final saasid = data.params[1];

    // 连接数据库
        await app.client.DbService().connect(userId, saasid);

        //  登录成功后触发心跳
        this.client.SystemService().cmd_heart()

        const getPropsKey = (key: string) => {
            // @ts-ignore
            return data.props[key] ? decodeURIComponent(data.props[key]) : ""
        }


        let save_keys: string[] = [
            ACCESS_TOKEN,
            APPID,
            APPSECRET,
            CFLAG,
            FILE_PROTECT,
            HIDE_USER_JOB,
            MSGENCRYPT,
            MSGTOKEN,
            ORG_IDS,
            P2P_THRESHOLD,
            PASSWORD_STRENGTH,
            ROLEACEXML,
            ROLE_IDS,
            SCLEN,
            SCNAME,
            SERVER_TYPE,
            SERVERMAPINFO,
            SERVER_TIME,
            SLDAY,
            // STIME,  // 先不用服务器的时间,因为他时区不准,当前失去的格式为字符串
            SVER,
            USERD_ISABLE_ACCEPTFILE,
            VERTYPE,
            WEBSERVER,
            UPIC,
            AUTOMATIC_OFFLINE,
            HIDE_USER_JOB,
            WARING_BT,
        ]
        for (const index in save_keys) {
            let key: string = save_keys[index]
            // console.log(key, ":", data.props[key])
            // @ts-ignore
            const val = getPropsKey(key);
            GlobalRepository.set_cache(key, val ? val : "");

        }

        GlobalRepository.set_cache(STIME, dateFormat((new Date).getTime().toString(), 'YYYY-MM-DD H:m:s'));


        // 添加人员
        const user = new UserModel();
        user.user_id = userId;
        user.user_ssid = data.params[1];
        user.user_login = data.params[2];
        user.user_name = data.params[3];
        user.user_session_id = data.params[4];
        user.user_server_id = data.params[5];
        user.user_picture = getPropsKey(UPIC);
        await UserRepository.addOrUpdate(user)

        GlobalRepository.set_cache(USER_ID, user.user_id);
        GlobalRepository.set_cache(SSID, user.user_ssid);
        GlobalRepository.set_cache(USER_LOGIN, user.user_login);
        GlobalRepository.set_cache(USER_NAME, user.user_name);

        GlobalRepository.set_cache(NEED_CHANGE_PWD, data.params[8]);

        this.handle_role_power(getPropsKey(ROLEACEXML))

  }
}
