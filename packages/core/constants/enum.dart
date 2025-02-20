enum StaticCode {
  normal, //  0-正常
  error, // 1-出错
  unfinished, // 2-命令未完成；
  needAck // 3-命令需要ack
}

enum EncryptCode {
  none, // 0-无操作
  aes256, // 1-AES256
  sm4 // 2-国产的SM4
}

enum OfflinePushType {
  none, // 0-无操作
  hw, // 1-华为
  xm, // 2-小米
  oppo, // 3-oppo
  vivo, // 4-vivo
  mz, // 5-魅族
  honor, // 6-荣耀
}

// 客户端加密方式
enum EnTypeType {
  imToken(-2), // IMToken验证
  token(-1), // Token
  none(0), // 明码
  md5(1), // MD5加密,不可逆
  aten(2), // ATEN
  sha256(3), // SHA256加密
  sha1(4), // SHA1加密,不可逆
  noneServer(5); // 数据库也是存的明文,取出后直接对比

  final int value;
  const EnTypeType(this.value);
}

// 操作类型
enum OpType {
  loginName(0), // 登录名
  userName(1), // 用户名
  phone(2); // 手机号

  final int value;
  const OpType(this.value);
}

// 平台
enum PlatformDesc {
  unknown('unknown'), // 未知平台
  win('win'), // Windows平台
  mac('mac'), // Mac平台
  qt('qt'), // Qt平台
  ios('ios'), // iOS平台
  android('android'), // 安卓平台
  web('web'); // Web平台

  final String value;
  const PlatformDesc(this.value);
}

// 客户端类型
enum PlatformType {
  unknown(0), // 未知
  win(1), // Windows (目前 web 也用 1)
  mac(2), // Mac
  qt(3), // Qt
  ios(4), // iOS
  android(5), // Android
  web(6); // Web

  final int value;
  const PlatformType(this.value);
}

//人员性别
enum UserSexType {
  unknown(0), // 未知
  man(1), // 男
  woman(2); // 女

  final int value;
  const UserSexType(this.value);
}

// 消息是否已读
enum MsgReadType {
  unread(0), // 未读
  read(1); // 已读

  final int value;
  const MsgReadType(this.value);
}

// 消息状态
enum MsgStatusType {
  timeout(-21), // 超时
  notFinish(-1), // 未完成
  normal(0), // 正常
  withdraw(1); // 撤回

  final int value;
  const MsgStatusType(this.value);
}

// 撤回指令返回值
enum MsgWithdrawType {
  fileNotExist(-2), // 文件不存在
  notFinish(-1), // 未完成
  normal(0); // 正常

  final int value;
  const MsgWithdrawType(this.value);
}

// 在线状态
enum UserStatusType {
  offline(0), // 离线
  online(1), // 在线
  away(2), // 离开
  busy(3), // 忙碌
  autoAway(4), // 自动离开
  noDisturb(5); // 请勿打扰

  final int value;
  const UserStatusType(this.value);
}

// 消息类型
enum MsgType {
  msg(0), // 普通消息
  msend(1), // 群发
  cmd(2), // 系统命令
  affiche(3), // 公告
  talk(3), // 会议
  mail(5), // 邮件
  web(6), // 网页
  board(7), // 客户端公告
  tempTalk(8), // 临时会话
  groupView(9), // 群视图
  autoReply(10), // 自动回复
  groupDis(11), // 群聊消息
  p2pFile(13), // P2P文件传输
  groupDisOpt(14); // 固定群人员变更

  final int value;
  const MsgType(this.value);
}

// 消息扩展类型
enum MsgExtType {
  none(""), // 默认
  shake("::Shake"), // 抖动
  vnc("AntRA"); // 远程控制

  final String value;
  const MsgExtType(this.value);
}

//登录验证方式
enum AuthType {
  none(0), // 系统方式
  ldap(1), // LDAP验证
  ad(2), // AD验证
  web(3), // 第三方验证 支持post/posts
  webToken(4); // 第三方 Web 端 Token 验证

  final int value;
  const AuthType(this.value);
}

// 客户端加密方式
enum EnType {
  imToken(-2), // IMToken验证
  token(-1), // Token
  none(0), // 明码
  md5(1), // MD5加密,不可逆
  aten(2), // ATEN
  sha256(3), // SHA256加密
  sha1(4), // SHA1加密,不可逆
  noneServer(5); // 数据库也是存的明文,取出后直接对比

  final int value;
  const EnType(this.value);
}

// 客户端设置
enum MsgFlag {
  normal(0), // 正常
  serverNoSave(1), // 服务端不保存消息
  clientNoSave(2), // 客户端不保存消息
  noAutoIOpen(4), // 客户端不自动设置IOpen
  noAutoIOpenQuite(8), // 客户端彻底不设置IOpen
  sendAtOnce(16), // 消息不进行通知，直接发送到客户端
  forcePopupTip(32), // 强制 Popup Tip , 不管消息有没有Download 过,都显示Tip
  localMsg(64), // 本地消息
  noRecCheck(128), // 没接收者时返回提示
  fromWebGuest(256), // From Web guest
  noOpenNty(512), // 不进行打开通知
  sendOnlyOnline(1024), // 只发给在线用户
  resetButton(2048), // 重置Button
  attitudeSet(4096), // 回复个人态度的
  getAttachPathFromAddin(8192), // 由Addin指定附件存放的位置
  showOnReadDlg(16384), // 在 ReadDlg 中显示,指定为消息模式
  showAtOnce(32768), // 不先显示Tip,而是马上显示消息
  sendToWeb(65536), // 发送到web上去
  confirm(131072), // 本消息要进行签收,要输入密码才能打开
  filter(262144), // 直接显示附件的内容,用作截图的
  filterNotes(524288), // BCC
  filterNty(1048576), // Auto reply
  mobilePhoneSupport(2097152), // 手机端支持
  topMsg(4194304), // 群置顶消息
  readDestory(16777216); // 阅后即焚消息

  final int value;
  const MsgFlag(this.value);
}

// 客户端开关
enum ClientFlag {
  disableBoard(1), // 禁止公告模块
  disableChangePwd(2), // 禁止客户端修改密码
  enableP2pFile(4), // 允许客户端P2P传输
  disableOpenMsgNotify(8), // 禁止客户端显示对方打开消息的通知
  disableGroupShare(16), // 禁止群共享文件
  disableAudio(32), // 禁止语音功能
  disableVideo(64), // 禁止视频功能
  avTransfer(128), // 客户端音视频、远程协助采用中转连接
  disableSortByState(256), // 禁止按在线状态排序
  openWatermark(512), // 开启水印
  openInviteUser(1024), // 开启好友验证的功能
  secLevel(2048), // 密级管理机制（现已更名为高管模式）
  sendMsgAtCertainTime(4096), // 开启定时发送
  enableSelfDestroy(8192), // 启用阅后即焚功能
  mustChangePasswordFirstTime(16384), // 首次登录修改密码
  disablePrivateChatAmongGroupMembers(65536), // 禁止群成员私聊
  enableBot(131072),
  enableFontSetting(524288),
  enableHiddenOfflineState(262144), // 隐藏离线状态与在线人数
  enableFileSecLevel(2097152), // 文件密级管理功能
  autoOffline(4194304), // 自动离开
  enableDepartmentGroup(8388608); // 是否启用部门群

  final int value;
  const ClientFlag(this.value);
}

// 最近消息表
enum RecentType {
  unknown("0"), // 未知
  user("1"), // 用户
  group("2"), // 群组
  addin("3"), // 插件
  notify("4"), // 通知内容
  dept("5"), // 部门
  mass("6"); // 群发消息

  final String value;
  const RecentType(this.value);
}

// 群状态
enum GroupStatus {
  unknown(0), // 未知
  normal(1), // 正常
  disabled(2), // 禁用
  deleted(3); // 删除

  final int value;
  const GroupStatus(this.value);
}

// 群是否本地
enum GroupIsLocal {
  no(0),
  yes(1);

  final int value;
  const GroupIsLocal(this.value);
}

// 群权限
enum GroupAce {
  normal(0),
  share(2), // 禁止群共享
  file(4); // 禁止群文件

  final int value;
  const GroupAce(this.value);
}

// 群通知类型
enum GroupNotifyType {
  egc("EGC"), // 创建群组通知
  eua("EUA"), // 群组人员加入通知，已在线用户
  nua("NUA"), // 群组人员加入通知，被增加用户
  era("ERA"), // 群组人员离开通知，已在线用户
  nra("NRA"), // 群组人员离开通知，被移除用户
  egm("EGM"), // 群组修改属性通知
  egt("EGT"), // 群主转让通知
  egf("EGF"), // 群组解散通知
  nnn("NNN"), // 修改群名片
  mute("MUTE"), // 某人被禁言,或全员禁言
  nnc("NNC"), // 群公告通知
  nro("NRO"); // 群组设置管理员通知

  final String value;
  const GroupNotifyType(this.value);
}

// 群类型
enum GroupType {
  normal(0), // 个人群
  fixed(1),
  discuss(2),
  dept(5);

  final int value;
  const GroupType(this.value);
}

// 群Flag
enum GroupFlag {
  normal(0), // 默认
  hiddenNotify(1); // 屏蔽群消息

  final int value;
  const GroupFlag(this.value);
}

// 群角色类型
enum MemberRole {
  user(0),
  manager(1),
  creator(2); // 创建者类型

  final int value;
  const MemberRole(this.value);
}

// 群成员类型
enum JoinType {
  pendingReview(0),
  normal(1),
  authorize(2),
  dissociate(3),
  disable(4);

  final int value;
  const JoinType(this.value);
}

// 群成员禁言
enum GroupMuteType {
  normal(0),
  ban(1); // 禁言

  final int value;
  const GroupMuteType(this.value);
}

// 消息类型
enum MsgBlockType {
  font("Font"),
  file("File"),
  text("Text"),
  at("at");

  final String value;
  const MsgBlockType(this.value);
}

// 文件类型
enum FileType {
  file(0),
  dir(1),
  img(2),
  sound(3),
  video(4);

  final int value;
  const FileType(this.value);
}

// 文件状态
enum FileStatus {
  notDownload(0),
  download(1);

  final int value;
  const FileStatus(this.value);
}

// 通知扩展类型
enum NotifyExtType {
  group(0); // 群云盘上传通知

  final int value;
  const NotifyExtType(this.value);
}

// 好友类型
enum FriendBothType {
  no(0),
  yes(1);

  final int value;
  const FriendBothType(this.value);
}

// XML解析类型
enum XmlToType {
  body(1),
  subject(2),
  content(3);

  final int value;
  const XmlToType(this.value);
}

// 组织类型
enum OrgType {
  orgAndFriend("0"), // 好友和组织用户
  orgUser("1"), // 组织用户
  friendUser("2"); // 好友用户

  final String value;
  const OrgType(this.value);
}

// 人员类型
enum PersonType {
  contact("contact");

  final String value;
  const PersonType(this.value);
}

// 密码强度
enum PasswordStrengthType {
  unknown(0),
  low(1),
  mid(2),
  height(3);

  final int value;
  const PasswordStrengthType(this.value);
}

// 查看他人权限
enum ProfileViewType {
  phoneNumShow(1),
  telShow(2), // 座机
  emailShow(4),
  roomShow(8),
  userIdShow(16),
  accountShow(32),
  idCardShow(64),
  shortNumShow(128); // 短号

  final int value;
  const ProfileViewType(this.value);
}

// 个人编辑权限
enum ProfileEditType {
  personAttr(1), // 个人属性(手机,座机,邮箱,房间号)
  job(2),
  userNote(4),
  avatar(8); // 个人头像

  final int value;
  const ProfileEditType(this.value);
}

// 角色消息权限
enum MsgAceType {
  disabledSendFile(1), // 禁止发送文件
  disabledVoice(4), // 禁止语音
  disabledVideo(8), // 视频
  disabledRemoteDesktop(16), // 远程桌面
  disabledCreateGroup(32), // 禁止创建群
  disabledScreenshot(64), // 禁止截图
  disabledDownloadFileMobile(128); // 禁止移动端下载文件

  final int value;
  const MsgAceType(this.value);
}

// 链接打开方式
enum TargetType {
  inner(1), // 内置浏览器
  system(2); // 外置浏览器

  final int value;
  const TargetType(this.value);
}

// 权限值类型
// 数据已经在服务器整合完,直接使用
enum RolePowerType {
  intAdd(0), // 整形值叠加
  intMax(1), // 整形值取大
  inputString(2), // 输入+字符串
  selectString(3); // 选择&字符串

  final int value;
  const RolePowerType(this.value);
}
