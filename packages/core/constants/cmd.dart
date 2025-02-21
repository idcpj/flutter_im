import '../exceptions/exceptions.dart';

enum CmdCode {
  //UpBalanceServer
  distribute(0x0002),

  // UpLoginServer
  login(0x0008), // 登录
  relogin(0x0009), // 断线重新登录
  newconnect(0x000A), // 新连接与会话建立关联
  clientout(0x000B), // 客户端退出
  laymobout(0x000C), // 客户端剔除移动端退出
  layout(0x000D), // 服务端剔除客户端退出
  mobpcout(0x000E), // 移动端剔除客户端退出

  getsmscode(0x0020), // 获取短信验证码
  getlogintoken(0x0021), // 获取登录令牌
  getaccesstoken(0x0022), // 单点登录 AccessToken
  checkloginstatus(0x0022), // 获取登陆服务器状态
  getsmslogincode(0x0023), // 获取短信登陆验证码

  sysSSIDUserCount(0x0064), // 获取SSID用户数
  sysServerUserCount(0x0065), // 获取登录服务用户数
  sysAllUserCount(0x0066), // 获取容器总用户数
  sysOutAddress(0x0070), // 得到当前连接的外部地址
  sysClientCheckLive(0x0071), // 客户端心跳检测
  sysServerCheckLive(0x0072), // 服务端心跳检测
  sysClientVerUpdate(0x0073), // 得到客户端的更新信息
  sysClientSkinUpdate(0x0074), // 得到客户端的皮肤包更新信息
  sysGetServerConfig(0x0075), // 得到容器服务器信息
  sysGetSystemConfig(0x0076), // 得到容器系统配置
  sysGetSSIDInfo(0x0077), // 得到SSID信息
  sysSetSSIDInfo(0x0078), // 设置SSID信息（暂不实现）
  sysSSIDOnlineUser(0x0079), // 得到指定SSID的在线用户信息
  sysSSIDOnlineUserNext(0x007A), // 得到指定SSID的在线用户信息，指定范围
  sysSSIDOnlineUserStatus(0x007B), // 得到指定SSID的在线用户信息，指定范围

  sysNetCenterConfig(0x0438), // 新建分布式配置通知到中心

  setWriting(0x0080), // 表示正在输入
  audioSignal(0x0081), // 音视频信令

  // ShareCmd
  hacLogin(0x0010), // 共享连接登陆
  hacOut(0x0011), // 共享连接退出

  // UpStatusServer
  chgSubscribeUser(0x0300), // 订阅用户在线状态
  chgChangeStatus(0x0301), // 更换在线状态
  chgUserLoginServer(0x0302), // 得到指定用户的登陆服务信息
  chgLogin(0x0303), // 更换登陆状态
  chgGetUserStatus(0x0304), // 得到批量用户在线状态
  chgExtNty(0x0306), // 扩展业务通知
  chgUserLoginInfo(0x0307), // 得到用户登录信息
  chgCommonNty(0x0308), // 通用业务通知
  chgUpdateStatusCache(0x0309), // 清除覆盖安装所在域在线状态缓存 推送到其他域
  chgGetDeptUserStatus(0x0310), // 服务器重启拉取其他域在线状态

  // 组织服务相关指令
  orgGetAllOrg(0x00C8), // 获取完整系统组织
  orgGetOrgMember(0x00C9), // 获取指定Org子节点信息
  orgGetOrgItem(0x00CA), // 获取指定Org信息
  orgGetOrgUserInfo(0x00CB), // 获取组织和好友所有人员基本信息
  orgGetMulUserInfo(0x00CC), // 获取一批人员基本信息
  orgGetUserInfo(0x00CD), // 获取人员一组信息
  orgSetUserInfo(0x00CE), // 更新人员一组信息
  orgGetUserPic(0x00CF), // 获取人员头像
  orgSetUserPic(0x00D0), // 更新人员头像
  orgSetUserPwd(0x00D1), // 修改密码
  orgSetCommonAddress(0x00D2), // 更新常用地址
  orgGetUserPosition(0x00E0), // 得到职位列表
  orgGetUserConfig(0x00E1), // 得到用户私有数据
  orgSetUserConfig(0x00E2), // 设置用户私有数据
  orgDeleteUserConfig(0x00E3), // 删除用户私有数据
  orgSearchEmployee(0x0100), // 搜索组织、群主、用户
  orgGetMassReceiver(0x0101), // 得到接受者信息
  orgGetAddIn(0x0102), // 得到插件信息
  orgGetUserAddIn(0x0103), // 得到用户插件信息
  orgGetBrandList(0x0104), // 得到铭牌列表
  orgGetFaceList(0x0105), // 得到自定义表情
  orgCreateFace(0x0106), // 创建自定义表情
  orgDeleteFace(0x0107), // 删除自定义表情
  orgGetAppList(0x0108), // 得到应用列表
  orgGetScanCode(0x0109), // 得到登陆扫描码
  orgScanLogin(0x010A), // 扫码验证登陆
  orgPcIsOnline(0x010B), // 客户端是否在线
  orgGetLogins(0x010D), // 根据姓名得到部门下的账号

  // 好友相关指令
  cusGetUserList(0x01F4), // 获取好友列表
  cusAddUser(0x01F5), // 添加好友
  cusRemoveUser(0x01F6), // 移除好友
  cusCreateGroup(0x01F7), // 创建好友组
  cusRenameGroup(0x01F8), // 好友组更名
  cusDeleteGroup(0x01F9), // 删除好友组
  cusMoveUser(0x01FA), // 移动好友
  cusInviteUser(0x01FB), // 邀请好友
  cusInviteReply(0x01FC), // 邀请好友回复 同意/拒绝
  cusPullbackUser(0x01FD), // 拉黑好友
  cusRemoveUserBoth(0x01FE), // 移除好友（双向）

  // UpMessageServer
  msgOfflineFile(0x0258), // 获取离线消息(这个指令似乎废弃),新消息通知直接直接客户端推送
  msgSendMsg(0x0259), // 发送消息
  msgReceiveMsg(0x025A), // 读取消息
  msgSetMsgReaded(0x025B), // 设置消息已读
  msgAck(0x025C), // ACK
  msgSendMassMsg(0x025D), // 群发消息
  msgMsgReceiver(0x025E), // 得到消息接受者
  msgAvSendRequest(0x025F), // 音视频命令发起
  msgAvSendReturn(0x0260), // 音视频命令回复
  msgSendCmd(0x0261), // 音视频会议命令发起
  msgCollectMsg(0x0262), // 收藏消息
  msgCollectMsgList(0x0263), // 收藏消息列表
  msgDeleteCollectMsg(0x0264), // 删除收藏消息

  // UpFileServer
  fileUpload(0x0270), // 文件上传
  fileData(0x0271), // 文件数据
  fileGet(0x0272), // 获取文件
  fileStart(0x0273), // 开始传输
  fileOk(0x0274), // 传输完成
  fileCancel(0x0275), // 取消传输
  fileInfo(0x0276), // 文件信息
  fileUndoFile(0x0280), // 撤回消息/删除消息/撤销文件

  // Nty
  ntyQr(0x0000), // 扫码登录后的通知
  ntyMsg(0x0320), // 新消息通知
  ntyOpm(0x0321), // 打开消息通知
  ntyNuss(0x0322), // 在线状态通知
  ntyGroup(0x0323), // 创建群组创建及修改的通知
  ntyGroupMsg(0x0324), // 群组新消息通知
  ntyWritting(0x0325), // 表示正在输入通知
  ntyUserInfo(0x0326), // 用户属性修改通知
  ntyPlatformUserInfo(0x0327), // 用户属性修改推送
  ntyPlatformUserPwd(0x0328), // 修改密码通知推送
  ntyOut(0x032A), // 账号设备退出通知
  ntyPlatformOpm(0x032B), // 多设备推送打开消息通知
  ntyPlatformGroupOpm(0x032C), // 多设备推送打开群组消息通知
  ntyServerConfig(0x032D), // 容器服务器信息推送
  ntySystemConfig(0x032E), // 容器系统配置推送
  ntyGetUserAllOrg(0x032F), // 获取系统组织命令通知
  ntyGetOrgUserInfo(0x0330), // 获取组织和好友所有用户通知
  ntyGetNuss(0x0331), // 批量用户在线状态通知
  ntyExtNty(0x0332), // 扩展业务通知
  ntyCus(0x0333), // 好友添加通知
  ntyUndoFile(0x0334), // 通知撤回消息/文件
  ntyAvBegin(0x0335), // 准备语音视频通知
  ntyAvSendRequest(0x0336), // 发送语音视频请求通知
  ntyAvSendReturn(0x0337), // 发送语音视频回复通知
  ntyAvPlatformReturn(0x0338), // 发送语音视频回复命令多设备推送
  ntyCmdNotify(0x0339), // 语音视频会议通知
  ntyGroupMsgNotify(0x033A), // 多设备群屏蔽消息通知
  ntyCollectMsg(0x033B), // 多设备收藏消息通知
  ntyDeleteCollectMsg(0x033C), // 多设备删除收藏消息通知
  ntyScanLogin(0x033D), // 扫描登陆验证成功通知
  ntyAudioSignal(0x033E), // 音视频信令通知
  ntyOrgChanged(0x033F), // 组织机构发生变化通知
  ntyComNty(0x0341), // 组织机构发生变化通知
  ntyIosOfflinePush(0x0342), // 移动端消息是否推送,此指令实际是有移动端发起

  // UpGroupServer
  groupList(0x0190), // 获取群组列表
  groupCreate(0x0191), // 创建群组
  groupExit(0x0192), // 退出群组
  groupModify(0x0193), // 修改群组名称
  groupDelete(0x0194), // 解散群组
  groupGetInfo(0x0195), // 得到群组信息
  groupSetInfo(0x0196), // 更新群组信息
  groupUpdateOwner(0x0197), // 群主转让
  groupGetManager(0x0198), // 得到群管理员
  groupSetManager(0x0199), // 设置群管理员
  groupUpdatePic(0x019A), // 更新群头像
  groupSetMsgFlag(0x019B), // 设置群屏蔽消息
  groupGetMsgFlag(0x019C), // 获取群屏蔽消息
  groupSetNotice(0x019D), // 设置群公告
  groupGetNotice(0x019E), // 得到群公告
  groupListNotice(0x019F), // 得到群公告列表
  groupListUser(0x01A0), // 获取群成员列表
  groupInviteUser(0x01A1), // 邀请人员
  groupRemoveUser(0x01A2), // 移除人员
  groupSendMsg(0x01A3), // 发送消息
  groupReadMsg(0x01A4), // 读取消息
  groupSetMsgReaded(0x01C0), // 设置消息已读
  groupAck(0x01C1), // ACK指令
  groupSetNickname(0x01C8), // 修改昵称
  groupMuteUser(0x01CF), // 设置禁言

  groupUpdateCache(0x410), // 群组更新缓存指令

  // UpPushServer
  pushIosMsg(0x384), // IOS消息推送
  pushNteMsg(0x385), // PUSH消息推送 群发消息、系统消息、群组操作命令等
  pushUpLocation(0x386), // 上传位置信息
  pushDownLocation(0x387), // 得到位置信息
  pushSetBadge(0x388), // 设置角标信息
  pushBackground(0x389), // 应用在前台和后台

  // UpWatchDogServer
  watchServiceStatus(0x03B0), // 得到UpServer的启动状态，如UpLoginServer等
  watchServiceStartStop(0x03B1), // 启动停止UpServer服务

  // Up CacheData
  orgUpdateSysConfig(0x03E8), // 更新系统配置信息
  orgUpdateSaasConfig(0x03E9), // 更新Saas配置信息
  orgUpdateServer(0x03EA), // 更新服务及关系
  orgRemoveServer(0x03EB), // 删除服务
  orgUpdateSaas(0x03EC), // 更新Saas及关系
  orgRemoveSaas(0x03ED), // 删除Saas
  orgAddDept(0x0400), // 创建组织
  orgUpdateDeptInfo(0x0401), // 更新组织
  orgRemoveDept(0x0402), // 删除组织
  orgAddUser(0x0403), // 创建用户
  orgUpdateUserInfo(0x0404), // 更新用户
  orgRemoveUser(0x0405), // 删除用户
  orgAddRole(0x0406), // 创建角色
  orgUpdateRoleInfo(0x0407), // 修改角色
  orgRemoveRole(0x0408), // 删除角色
  orgAddRelation(0x0409), // 添加用户
  orgRemoveRelation(0x040A), // 移除用户
  orgUpdateRelation(0x040B), // 更新父节点组织关系
  orgUpdateRoleBaseAce(0x040C), // 更新角色基本权限
  orgUpdateRoleDeptAce(0x040D), // 更新角色组织权限
  orgUpdateLicenseSaas(0x040E), // 更新SAAS授权
  orgUpdateLicenseSystem(0x040F), // 更新系统授权
  orgUpdateAddin(0x0420), // 创建和更新插件
  orgRemoveAddin(0x0421), // 删除插件
  orgUpdateSaasCache(0x0422), // 更新Saas组织机构缓存
  orgUpdateOrgUserOrder(0x0423), // 更新组织用户排序号
  orgUpdateSysTokenAppInfo(0x0424), // 更新令牌验证信息缓存
  orgUpdateUpgrade(0x0425), // 更新安装包和皮肤包升级版本号
  orgUpdatePosition(0x0426), // 更新职位信息
  orgCleanUserDevice(0x0427), // 清除用户设备号
  orgUpdateAddinRoleAce(0x0428), // 更新插件角色权限
  orgUpdateBrandInfo(0x0429), // 更新铭牌信息
  orgUpdateTimeTask(0x042A), // 更新定时任务信息
  orgUpdateApp(0x042B), // 创建和更新应用
  orgRemoveApp(0x042C), // 移除应用
  orgUpdateUserSecInfo(0x042D), // 更新用户安全等级
  orgUpdateUserInfoPush(0x042E), // 更新用户信息推送地址

  apiDecryptData(0x04C0), // 解密密码字符串 带KEY
  apiEncryptData(0x04C1), // 加密 带KEY
  apiDecryptSn(0x04C2), // 解密sn字符串
  apiSetServerStatus(0x04C3), // 启停服务
  apiVerifySn(0x04C4), // 验证Sn
  apiVerifyToken(0x04C5), // 验证令牌
  apiVerifyCerts(0x04C6), // 验证推送证书

  // 扩展, 本地模拟通知
  clientUndofile(0x5001); // 撤回时,撤回引用中的消息

  final int value;
  const CmdCode(this.value);

  /// 从整数值获取对应的 CmdCode
  static CmdCode fromValue(int value) {
    return CmdCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgsException('Invalid CmdCode value: $value'),
    );
  }
}
