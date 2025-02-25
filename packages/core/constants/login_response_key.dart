part of 'constants.dart';

enum LoginResKey {
  // 服务器信息
  webserver('webserver'),
  servermapinfo('servermapinfo'),

  // 系统信息
  appid('appid'),
  ssid('ssid'),
  domain('domain'),
  serverType('server_type'),
  serverTime('servertime'),
  slday('slday'),
  stime('stime'),
  sver('sver'),
  vertype('vertype'),
  upic('upic'),

  // 安全信息
  accessToken('access_token'),
  msgtoken('msgtoken'),
  msgEncrypt('msgencrypt'),
  appsecret('appsecret'),

  // 权限信息
  fileProtect('fileprotect'),
  roleacexml('roleacexml'),
  p2pThreshold('p2pthreshold'),
  roleIds('roleids'),
  userDisableAcceptfile('userdisableacceptfile'),

  // 人员信息
  passwordStrength('password_strength'),
  hideUserJob('hide_user_job'), // 隐藏职位标签
  orgIds('orgids'),
  userId('user_id'),
  userPic('pic'),
  userName('user_name'),
  userLogin('user_login'),
  userPwd('user_pwd'),
  needChangePwd('need_change_pwd'),

  // 其他信息
  cflag('cflag'),
  sclen('sclen'),
  scname('scname'),
  automaticOffline('automatic_offline'), // 自动离开时间
  waringBt('waring_bt'), // 聊天框提示信息

  // 组织架构信息
  syncId('sync_id'),
  appSecret('www.upsoft01.com');

  final String value;
  const LoginResKey(this.value);
}
