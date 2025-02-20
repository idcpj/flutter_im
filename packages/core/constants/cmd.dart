// UpBalanceServer
import '../types/types.dart';

const CmdCode CMD_DISTRIBUTE = 0x0002;

// UpLoginServer
const CmdCode CMD_LOGIN = 0x0008; // 登录

const CmdCode CMD_RELOGIN = 0x0009; // 断线重新登录
const CmdCode CMD_NEWCONNECT = 0x000A; // 新连接与会话建立关联
const CmdCode CMD_CLIENTOUT = 0x000B; // 客户端退出
const CmdCode CMD_LAYMOBOUT = 0x000C; // 客户端剔除移动端退出
const CmdCode CMD_LAYOUT = 0x000D; // 服务端剔除客户端退出
const CmdCode CMD_MOBPCOUT = 0x000E; // 移动端剔除客户端退出

const CmdCode CMD_GETSMSCODE = 0x0020; // 获取短信验证码
const CmdCode CMD_GETLOGINTOKEN = 0x0021; // 获取登录令牌
const CmdCode CMD_GETACCESSTOKEN = 0x0022; // 单点登录 AccessToken

const CmdCode CMD_CHECKLOGINSTATUS = 0x0022; // 获取登陆服务器状态

const CmdCode CMD_GETSMSLOGINCODE = 0x0023; // 获取短信登陆验证码

const CmdCode CMD_SYS_SSIDUSERCOUNT = 0x0064; // 获取SSID用户数
const CmdCode CMD_SYS_SERVERUSERCOUNT = 0x0065; // 获取登录服务用户数
const CmdCode CMD_SYS_ALLUSERCOUNT = 0x0066; // 获取容器总用户数
const CmdCode CMD_SYS_OUTADDRESS = 0x0070; // 得到当前连接的外部地址
const CmdCode CMD_SYS_CLIENTCHECKLIVE = 0x0071; // 客户端心跳检测
const CmdCode CMD_SYS_SERVERCHECKLIVE = 0x0072; // 服务端心跳检测
const CmdCode CMD_SYS_CLIENTVERUPDATE = 0x0073; // 得到客户端的更新信息
const CmdCode CMD_SYS_CLIENTSKINUPDATE = 0x0074; // 得到客户端的皮肤包更新信息
const CmdCode CMD_SYS_GETSERVERCONFIG = 0x0075; // 得到容器服务器信息
const CmdCode CMD_SYS_GETSYSTEMCONFIG = 0x0076; // 得到容器系统配置
const CmdCode CMD_SYS_GETSSIDINFO = 0x0077; // 得到SSID信息
const CmdCode CMD_SYS_SETSSIDINFO = 0x0078; // 设置SSID信息（暂不实现）
const CmdCode CMD_SYS_SSIDONLINEUSER = 0x0079; // 得到指定SSID的在线用户信息
const CmdCode CMD_SYS_SSIDONLINEUSERNEXT = 0x007A; // 得到指定SSID的在线用户信息，指定范围
const CmdCode CMD_SYS_SSIDONLINEUSERSTATUS = 0x007B; // 得到指定SSID的在线用户信息，指定范围

const CmdCode CMD_SYS_NET_CENTER_CONFIG = 0x0438; // 新建分布式配置通知到中心

const CmdCode CMD_SETWRITTING = 0x0080; // 表示正在输入
const CmdCode CMD_AUDIO_SIGNAL = 0x0081; // 音视频信令

// ShareCmd
const CmdCode CMD_HAC_LOGIN = 0x0010; // 共享连接登陆
const CmdCode CMD_HAC_OUT = 0x0011; // 共享连接退出

// UpStatusServer
const CmdCode CMD_CHG_SUBSCRIBEUSER = 0x0300; // 订阅用户在线状态
const CmdCode CMD_CHG_CHANGESTATUS = 0x0301; // 更换在线状态
const CmdCode CMD_CHG_USERLOGINSERVER = 0x0302; // 得到指定用户的登陆服务信息
const CmdCode CMD_CHG_LOGIN = 0x0303; // 更换登陆状态
const CmdCode CMD_CHG_GETUSERSTATUS = 0x0304; // 得到批量用户在线状态
// const CmdCode CMD_CHG_SYNCUSERSTATUS = 0x0305; // 同步用户在线状态,原服务器内部接口
const CmdCode CMD_CHG_EXTNTY = 0x0306; // 扩展业务通知
const CmdCode CMD_CHG_USERLOGININFO = 0x0307; // 得到用户登录信息
const CmdCode CMD_CHG_COMMONNTY = 0x0308; // 通用业务通知
const CmdCode CMD_CHG_UPDATE_STATUS_CACHE = 0x0309; // 清除覆盖安装所在域在线状态缓存 推送到其他域
const CmdCode CMD_CHG_GETDEPTUSERSTATUS = 0x0310; // 服务器重启拉取其他域在线状态

// UpOrgServer

const CmdCode CMD_ORG_GETALLORG = 0x00C8; // 获取完整系统组织
const CmdCode CMD_ORG_GETORGMEMBER = 0x00C9; // 获取指定Org子节点信息
const CmdCode CMD_ORG_GETORGITEM = 0x00CA; // 获取指定Org信息

const CmdCode CMD_ORG_GETORGUSERINFO = 0x00CB; // 获取组织和好友所有人员基本信息
const CmdCode CMD_ORG_GETMULUSERINFO = 0x00CC; // 获取一批人员基本信息
const CmdCode CMD_ORG_GETUSERINFO = 0x00CD; // 获取人员一组信息
const CmdCode CMD_ORG_SETUSERINFO = 0x00CE; // 更新人员一组信息
const CmdCode CMD_ORG_GETUSERPIC = 0x00CF; // 获取人员头像
const CmdCode CMD_ORG_SETUSERPIC = 0x00D0; // 更新人员头像
const CmdCode CMD_ORG_SETUSERPWD = 0x00D1; // 修改密码
const CmdCode CMD_ORG_SETCOMMONADDRESS = 0x00D2; // 更新常用地址
const CmdCode CMD_ORG_GETUSERPOSITION = 0x00E0; // 得到职位列表
const CmdCode CMD_ORG_GETUSERCONFIG = 0x00E1; // 得到用户私有数据
const CmdCode CMD_ORG_SETUSERCONFIG = 0x00E2; // 设置用户私有数据
const CmdCode CMD_ORG_DELETEUSERCONFIG = 0x00E3; // 删除用户私有数据
const CmdCode CMD_ORG_SEARCHEMPLOYEE = 0x0100; // 搜索组织、群主、用户
const CmdCode CMD_ORG_GETMASSRECEIVER = 0x0101; // 得到接受者信息
const CmdCode CMD_ORG_GETADDIN = 0x0102; // 得到插件信息

const CmdCode CMD_ORG_GETUSERADDIN = 0x0103; // 得到用户插件信息
const CmdCode CMD_ORG_GETBRANDLIST = 0x0104; // 得到铭牌列表
const CmdCode CMD_ORG_GETFACELIST = 0x0105; // 得到自定义表情
const CmdCode CMD_ORG_CREATEFACE = 0x0106; // 创建自定义表情
const CmdCode CMD_ORG_DELETEFACE = 0x0107; // 删除自定义表情
const CmdCode CMD_ORG_GETAPPLIST = 0x0108; // 得到应用列表
const CmdCode CMD_ORG_GETSACNCODE = 0x0109; // 得到登陆扫描码
const CmdCode CMD_ORG_SACNLOGIN = 0x010A; // 扫码验证登陆
const CmdCode CMD_ORG_PCISONLINE = 0x010B; // 客户端是否在线

const CmdCode CMD_ORG_GET_LOGINS = 0x010D; // 根据姓名得到部门下的账号

const CmdCode CMD_CUS_GETUSERLIST = 0x01F4; // 获取好友列表
const CmdCode CMD_CUS_ADDUSER = 0x01F5; // 添加好友
const CmdCode CMD_CUS_REMOVEUSER = 0x01F6; // 移除好友
const CmdCode CMD_CUS_CREATEGROUP = 0x01F7; // 创建好友组
const CmdCode CMD_CUS_RENAMEGROUP = 0x01F8; // 好友组更名
const CmdCode CMD_CUS_DELETEGROUP = 0x01F9; // 删除好友组
const CmdCode CMD_CUS_MOVEUSER = 0x01FA; // 移动好友
const CmdCode CMD_CUS_INVITEUSER = 0x01FB; // 邀请好友
const CmdCode CMD_CUS_INVITEREPLY = 0x01FC; // 邀请好友回复 同意/拒绝
const CmdCode CMD_CUS_PULLBACKUSER = 0x01FD; // 拉黑好友
const CmdCode CMD_CUS_REMOVEUSERBOTH = 0x01FE; // 移除好友（双向）

// UpMessageServer

const CmdCode CMD_MSG_OFFLINEFILE = 0x0258; // 获取离线消息(这个指令似乎废弃),新消息通知直接直接客户端推送
const CmdCode CMD_MSG_SENDMSG = 0x0259; // 发送消息
const CmdCode CMD_MSG_RECEIVEMSG = 0x025A; // 读取消息
const CmdCode CMD_MSG_SETMSGREADED = 0x025B; // 设置消息已读
const CmdCode CMD_MSG_ACK = 0x025C; // ACK
const CmdCode CMD_MSG_SENDMASSMSG = 0x025D; // 群发消息
const CmdCode CMD_MSG_MSGRECEIVER = 0x025E; // 得到消息接受者
const CmdCode CMD_MSG_AV_SENDREQUEST = 0x025F; // 音视频命令发起
const CmdCode CMD_MSG_AV_SENDRETURN = 0x0260; // 音视频命令回复
const CmdCode CMD_MSG_SENDCMD = 0x0261; // 音视频会议命令发起
const CmdCode CMD_MSG_COLLECTMSG = 0x0262; // 收藏消息
const CmdCode CMD_MSG_COLLECTMSGLIST = 0x0263; // 收藏消息列表
const CmdCode CMD_MSG_DELETECOLLECTMSG = 0x0264; // 删除收藏消息

// UpFileServer
const CmdCode CMD_FILE_FUPLOAD = 0x0270;
const CmdCode CMD_FILE_FDATA = 0x0271;
const CmdCode CMD_FILE_FGET = 0x0272;
const CmdCode CMD_FILE_FSTART = 0x0273;
const CmdCode CMD_FILE_FOK = 0x0274;
const CmdCode CMD_FILE_FCANCEL = 0x0275;
const CmdCode CMD_FILE_FINFO = 0x0276;
const CmdCode CMD_FILE_UNDOFILE = 0x0280; // 撤回消息/删除消息/撤销文件

// Nty
const CmdCode CMD_NTE_QR = 0x0000; // 扫码登录后的通知
const CmdCode CMD_NTE_MSG = 0x0320; // 新消息通知
const CmdCode CMD_NTE_OPM = 0x0321; // 打开消息通知
const CmdCode CMD_NTE_NUSS = 0x0322; // 在线状态通知
const CmdCode CMD_NTE_GROUP = 0x0323; // 创建群组创建及修改的通知
const CmdCode CMD_NTE_GROUP_MSG = 0x0324; // 群组新消息通知
const CmdCode CMD_NTE_WRITTING = 0x0325; // 表示正在输入通知
const CmdCode CMD_NTE_USERINFO = 0x0326; // 用户属性修改通知
const CmdCode CMD_NTE_PLATFORM_USERINFO = 0x0327; // 用户属性修改推送
const CmdCode CMD_NTE_PLATFORM_USERPWD = 0x0328; // 修改密码通知推送
const CmdCode CMD_NTY_OUT = 0x032A; // 账号设备退出通知
const CmdCode CMD_NTE_PLATFORM_OPM = 0x032B; // 多设备推送打开消息通知
const CmdCode CMD_NTE_PLATFORM_GROUP_OPM = 0x032C; // 多设备推送打开群组消息通知
const CmdCode CMD_NTE_SERVERCONFIG = 0x032D; // 容器服务器信息推送
const CmdCode CMD_NTE_SYSTEMCONFIG = 0x032E; // 容器系统配置推送
const CmdCode CMD_NTE_GET_USERALLORG = 0x032F; // 获取系统组织命令通知
const CmdCode CMD_NTE_GET_ORGUSERINFO = 0x0330; // 获取组织和好友所有用户通知
const CmdCode CMD_NTE_GET_NUSS = 0x0331; // 批量用户在线状态通知
const CmdCode CMD_NTE_EXTNTY = 0x0332; // 扩展业务通知
const CmdCode CMD_NTE_CUS = 0x0333; // 好友添加通知
const CmdCode CMD_NTE_UNDOFILE = 0x0334; // 通知撤回消息/文件
const CmdCode CMD_NTE_AV_BEGIN = 0x0335; // 准备语音视频通知
const CmdCode CMD_NTE_AV_SENDREQUEST = 0x0336; // 发送语音视频请求通知
const CmdCode CMD_NTE_AV_SENDRETURN = 0x0337; // 发送语音视频回复通知
const CmdCode CMD_NTE_AV_PLATFORM_RETURN = 0x0338; // 发送语音视频回复命令多设备推送
const CmdCode CMD_NTE_CMD_NOTIFY = 0x0339; // 语音视频会议通知
const CmdCode CMD_NTE_GROUPMSGNOTIFY = 0x033A; // 多设备群屏蔽消息通知
const CmdCode CMD_NTE_COLLECTMSG = 0x033B; // 多设备收藏消息通知
const CmdCode CMD_NTE_DELETECOLLECTMSG = 0x033C; // 多设备删除收藏消息通知
const CmdCode CMD_NTE_SACNLOGIN = 0x033D; // 扫描登陆验证成功通知
const CmdCode CMD_NTE_AUDIOSIGNAL = 0x033E; // 音视频信令通知
const CmdCode CMD_NTE_ORGCHANGED = 0x033F; // 组织机构发生变化通知
const CmdCode CMD_NTE_COMNTY = 0x0341; // 组织机构发生变化通知
const CmdCode CMD_NTE_IOSOFFLINEPUSH = 0x0342; // 移动端消息是否推送,此指令实际是有移动端发起
// const CmdCode CMD_NTE_GETIOSOFFLINEPUSH = 0x0343; // 获取移动端消息是否推送 -没被使用

// UpGroupServer
const CmdCode CMD_GROUP_LIST = 0x0190; // 获取群组列表
const CmdCode CMD_GROUP_CREATE = 0x0191; // 创建群组
const CmdCode CMD_GROUP_EXIT = 0x0192; // 退出群组
const CmdCode CMD_GROUP_MODIFY = 0x0193; // 修改群组名称
const CmdCode CMD_GROUP_DELETE = 0x0194; // 解散群组
const CmdCode CMG_GROUP_GETINFO = 0x0195; // 得到群组信息
const CmdCode CMD_GROUP_SETINFO = 0x0196; // 更新群组信息
const CmdCode CMD_GROUP_UPDATEOWNER = 0x0197; // 群主转让
const CmdCode CMD_GROUP_GETMANAGER = 0x0198; // 得到群管理员
const CmdCode CMD_GROUP_SETMANAGER = 0x0199; // 设置群管理员
const CmdCode CMD_GROUP_UPDATEPIC = 0x019A; // 更新群头像
const CmdCode CMD_GROUP_SETMSGFLAG = 0x019B; // 设置群屏蔽消息
const CmdCode CMD_GROUP_GETMSGFLAG = 0x019C; // 获取群屏蔽消息
const CmdCode CMD_GROUP_SETNOTICE = 0x019D; // 设置群公告
const CmdCode CND_GROUP_GETNOTICE = 0x019E; // 得到群公告
const CmdCode CMD_GROUP_LISTNOTICE = 0x019F; // 得到群公告列表
const CmdCode CMD_GROUP_LISTUSER = 0x01A0; // 获取群成员列表
const CmdCode CMD_GROUP_INVITEUSER = 0x01A1; // 邀请人员
const CmdCode CMD_GROUP_REMOVEUSER = 0x01A2; // 移除人员
const CmdCode CMD_GROUP_SENDMSG = 0x01A3; // 发送消息
const CmdCode CMD_GROUP_READMSG = 0x01A4; // 读取消息
const CmdCode CMD_GROUP_SETMSGREADED = 0x01C0; // 设置消息已读
const CmdCode CMD_GROUP_ACK = 0x01C1; // ACK指令
const CmdCode CMD_GROUP_SETNICKNAME = 0x01C8; // 修改昵称
const CmdCode CMD_GROUP_MUTE_USER = 0x01CF; // 设置禁言

const CmdCode CMD_GROUP_UPDATE_CACHE = 0x410; // 群组更新缓存指令

// UpPushServer
const CmdCode CMD_PUSH_IOSMSG = 0x384; // IOS消息推送
const CmdCode CMD_PUSH_NTEMSG = 0x385; // PUSH消息推送 群发消息、系统消息、群组操作命令等
const CmdCode CMD_PUSH_UP_LOCATION = 0x386; // 上传位置信息
const CmdCode CMD_PUSH_DOWN_LOCATION = 0x387; // 得到位置信息
const CmdCode CMD_PUSH_SET_BADGE = 0x388; // 设置角标信息
const CmdCode CMD_PUSH_BACKGROUND = 0x389; // 应用在前台和后台

// UpWatchDogServer
const CmdCode CMD_WATCH_SERVICE_STATUS = 0x03B0; // 得到UpServer的启动状态，如UpLoginServer等
const CmdCode CMD_WATCH_SERVICE_STARTSTOP = 0x03B1; // 启动停止UpServer服务

// Up CacheData
const CmdCode CMD_ORG_UPDATE_SYSCONFIG = 0x03E8; // 更新系统配置信息
const CmdCode CMD_ORG_UPDATE_SAASCONFIG = 0x03E9; // 更新Saas配置信息
const CmdCode CMD_ORG_UPDATE_SERVER = 0x03EA; // 更新服务及关系
const CmdCode CMD_ORG_REMOVE_SERVER = 0x03EB; // 删除服务
const CmdCode CMD_ORG_UPDATE_SAAS = 0x03EC; // 更新Saas及关系
const CmdCode CMD_ORG_REMOVE_SAAS = 0x03ED; // 删除Saas
const CmdCode CMD_ORG_ADD_DEPT = 0x0400; // 创建组织
const CmdCode CMD_ORG_UPDATE_DEPTINFO = 0x0401; // 更新组织
const CmdCode CMD_ORG_REMOVE_DEPT = 0x0402; // 删除组织
const CmdCode CMD_ORG_ADD_USER = 0x0403; // 创建用户
const CmdCode CMD_ORG_UPDATE_USERINFO = 0x0404; // 更新用户
const CmdCode CMD_ORG_REMOVE_USER = 0x0405; // 删除用户
const CmdCode CMD_ORG_ADD_ROLE = 0x0406; // 创建角色
const CmdCode CMD_ORG_UPDATE_ROLEINFO = 0x0407; // 修改角色
const CmdCode CMD_ORG_REMOVE_ROLE = 0x0408; // 删除角色
const CmdCode CMD_ORG_ADD_RELATION = 0x0409; // 添加用户
const CmdCode CMD_ORG_REMOVE_RELATION = 0x040A; // 移除用户
const CmdCode CMD_ORG_UPDATE_RELATION = 0x040B; // 更新父节点组织关系
const CmdCode CMD_ORG_UPDATE_ROLEBASEACE = 0x040C; // 更新角色基本权限
const CmdCode CMD_ORG_UPDATE_ROLEDEPTACE = 0x040D; // 更新角色组织权限
const CmdCode CMD_ORG_UPDATE_LICENSE_SAAS = 0x040E; // 更新SAAS授权
const CmdCode CMD_ORG_UPDATE_LICENSE_SYSTEM = 0x040F; // 更新系统授权
const CmdCode CMD_ORG_UPDATE_ADDIN = 0x0420; // 创建和更新插件
const CmdCode CMD_ORG_REMOVE_ADDIN = 0x0421; // 删除插件
const CmdCode CMD_ORG_UPDATE_SAASCACHE = 0x0422; // 更新Saas组织机构缓存
const CmdCode CMD_ORG_UPDATE_ORGUSERORDER = 0x0423; // 更新组织用户排序号
const CmdCode CMD_ORG_UPDATE_SYSTOKENAPPINFO = 0x0424; // 更新令牌验证信息缓存
const CmdCode CMD_ORG_UPDATE_UPGRADE = 0x0425; // 更新安装包和皮肤包升级版本号
const CmdCode CMD_ORG_UPDATE_POSITION = 0x0426; // 更新职位信息
const CmdCode CMD_ORG_CLEAN_USERDEVICE = 0x0427; // 清除用户设备号
const CmdCode CMD_ORG_UPDATE_ADDINROLEACE = 0x0428; // 更新插件角色权限
const CmdCode CMD_ORG_UPDATE_BRANDINFO = 0x0429; // 更新铭牌信息
const CmdCode CMD_ORG_UPDATE_TIMETASK = 0x042A; // 更新定时任务信息
const CmdCode CMD_ORG_UPDATE_APP = 0x042B; // 创建和更新应用
const CmdCode CMD_ORG_REMOVE_APP = 0x042C; // 移除应用
const CmdCode CMD_ORG_UPDATE_USERSECINFO = 0x042D; // 更新用户安全等级
const CmdCode CMD_ORG_UPDATE_USERINFOPUSH = 0x042E; // 更新用户信息推送地址

const CmdCode CMD_API_DECRYPTDATA = 0x04C0; // 解密密码字符串 带KEY
const CmdCode CMD_API_ENCRYPTDATA = 0x04C1; // 加密 带KEY
const CmdCode CMD_API_DECRYPTSN = 0x04C2; // 解密sn字符串
const CmdCode CMD_API_SETSERVERSTATUS = 0x04C3; // 启停服务
const CmdCode CMD_API_VERIFYSN = 0x04C4; // 验证Sn
const CmdCode CMD_API_VERIFYTOKEN = 0x04C5; // 验证令牌
const CmdCode CMD_API_VERIFYCERTS = 0x04C6; // 验证推送证书

// 扩展, 本地模拟通知

// 撤回时,撤回引用中的消息
const CmdCode CMD_CLIENT_UNDOFILE = 0x5001;
