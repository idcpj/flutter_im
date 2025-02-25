import 'package:core/constants/constants.dart';
import 'package:core/types/types.dart';
import 'package:core/domain/dao/repository/repository.dart';
import 'base_service.dart';

class ConfigService extends BaseService {
  ConfigService({required super.app});

  ServerMapInfo? _currServerMap;

  EncryptCode msgEncrypt() {
    return CacheRepository.getCache(LoginResKey.msgEncrypt.value) as EncryptCode;
  }

  //图片通过代理访问,因为他们在不同的站点
  String proxy_webserver() {
    return "";
  }

  String webserver() {
    var url = CacheRepository.getCache(LoginResKey.webserver.value);
    if (url.isNotEmpty) {
      return url;
    }
    return getCurrServderMapInfo()?.loginServer ?? "";
  }

  ServerMapInfo? getCurrServderMapInfo() {
    if (_currServerMap != null) {
      return _currServerMap!;
    }
    var serverMapInfo = CacheRepository.getCache<List<ServerMapInfo>?>(LoginResKey.servermapinfo.value);
    if (serverMapInfo != null && serverMapInfo.isNotEmpty) {
      var hostname = app.config.host;
      var webServer = serverMapInfo.firstWhere((item) {
        return item.loginServer == hostname;
      });
      _currServerMap = webServer;
    }

    return _currServerMap;
  }

  String saasId() {
    return CacheRepository.getCache<String>(LoginResKey.ssid.value);
  }

  String saasName() {
    return CacheRepository.getCache<String>(LoginResKey.scname.value);
  }

  String appId() {
    return CacheRepository.getCache<String>(LoginResKey.appid.value);
  }

  String userName() {
    return CacheRepository.getCache<String>(LoginResKey.userName.value);
  }

  String loginName() {
    return CacheRepository.getCache<String>(LoginResKey.userLogin.value);
  }

  String userId() {
    return CacheRepository.getCache<String>(LoginResKey.userId.value);
  }

  String msgToken() {
    return CacheRepository.getCache<String>(LoginResKey.msgtoken.value);
  }

  String uPic() {
    return CacheRepository.getCache<String>(LoginResKey.upic.value);
  }

  //2025-02-20%2004:46:01
  String loginTime() {
    return CacheRepository.getCache<String>(LoginResKey.stime.value);
  }

  String fileFHost() {
    return getCurrServderMapInfo()?.fileServer ?? "";
  }

  String waringBt() {
    return CacheRepository.getCache<String>(LoginResKey.waringBt.value);
  }

  // 权限
  // 手机号
  isShowPhoneNum() {
    return CacheRepository.preViewPower(ProfileViewType.phoneNumShow);
  }

  // 座机
  isShowTel() {
    return CacheRepository.preViewPower(ProfileViewType.telShow);
  }

  // 邮箱
  isShowEmail() {
    return CacheRepository.preViewPower(ProfileViewType.emailShow);
  }

  // 房间
  isShowRoom() {
    return CacheRepository.preViewPower(ProfileViewType.roomShow);
  }

  // 人员id
  isShowUserId() {
    return CacheRepository.preViewPower(ProfileViewType.userIdShow);
  }

  // 账号
  isShowAccount() {
    return CacheRepository.preViewPower(ProfileViewType.accountShow);
  }

  // 身份证
  isShowIDCard() {
    return CacheRepository.preViewPower(ProfileViewType.idCardShow);
  }

  // 短号
  isShowShortNum() {
    return CacheRepository.preViewPower(ProfileViewType.shortNumShow);
  }

  // 允许编辑个人属性
  enableEditPersonAttr() {
    return CacheRepository.profileEditPower(ProfileEditType.personAttr);
  }

  // 职位
  enableEditJob() {
    return CacheRepository.profileEditPower(ProfileEditType.job);
  }

  // 签名
  enableEditNote() {
    return CacheRepository.profileEditPower(ProfileEditType.userNote);
  }

  // 个人头像
  enableEditAVATAR() {
    return CacheRepository.profileEditPower(ProfileEditType.avatar);
  }

  // 文件发送大小限制
  // size 字节
  enabledSendFileSize(size) {
    return CacheRepository.getCache<RolePower>(LoginResKey.roleacexml.value).attachSizeLimit * 1024 * 1034 - size >= 0;
  }

  // 禁止文件发送
  disabledSendFile() {
    return CacheRepository.msgAce(MsgAceType.disabledSendFile);
  }

  // 禁止语音
  disabledCreateGroup() {
    return CacheRepository.msgAce(MsgAceType.disabledCreateGroup);
  }

  // 禁止截图
  disabledScreenshot() {
    return CacheRepository.msgAce(MsgAceType.disabledScreenshot);
  }

  // 自动离开时间
  int autoLevelTime() {
    return CacheRepository.getCache<int>(LoginResKey.automaticOffline.value);
  }

  // 隐藏职位标签
  isHideUserJob() {
    return CacheRepository.getCache<int>(LoginResKey.hideUserJob.value) == 1;
  }

  // 密码强度,如果不存在,则使用中等密码
  PasswordStrengthType passwordStrength() {
    return CacheRepository.getCache<PasswordStrengthType?>(LoginResKey.passwordStrength.value) ?? PasswordStrengthType.mid;
  }

  // 自己是否需要手改密码
  needChangePwd() {
    return CacheRepository.getCache<String>(LoginResKey.needChangePwd.value) == "1";
  }

  // 上线提醒
  setUserOnlineAlert(List<String> userid) {
    CacheRepository.setPersonConfig(PersonType.contact, userid.where((item) => item.isNotEmpty).join(";"));
  }

  // 上线提醒
  List<String> getUserOnlineAlert() {
    return CacheRepository.getPersonConfig(PersonType.contact).split(";");
  }

  //================ 客户端后台开关 ================

  // 开启水印
  isOpenWater() {
    return CacheRepository.isCFlag(ClientFlag.openWatermark);
  }

  // 禁止按在线状态排序,0=是否上线先排序,1=强制按排序号
  isOpenSortingByOnline() {
    return CacheRepository.isCFlag(ClientFlag.disableSortByState);
  }

  // 是否开启了高管模式
  isOpenUserLevel() {
    return CacheRepository.isCFlag(ClientFlag.secLevel);
  }

  // 是否禁止群共享
  isProhibitionGroupShare() {
    return CacheRepository.isCFlag(ClientFlag.disableGroupShare);
  }

  // 定时发送
  isOpenScheduledSends() {
    return CacheRepository.isCFlag(ClientFlag.sendMsgAtCertainTime);
  }

  // 阅后即焚
  isOpenReadDestory() {
    return CacheRepository.isCFlag(ClientFlag.enableSelfDestroy);
  }

  // 禁止群成员私聊
  isProhibitionGroupMemeberPrivateChat() {
    return CacheRepository.isCFlag(ClientFlag.disablePrivateChatAmongGroupMembers);
  }

  // 首次登录修改密码
  isOpenFristLognChangePwd() {
    return CacheRepository.isCFlag(ClientFlag.mustChangePasswordFirstTime);
  }

  // 头像常亮
  isOpenStatusSolidOn() {
    return CacheRepository.isCFlag(ClientFlag.enableHiddenOfflineState);
  }

  // 是否开启部门群
  isOpenDeptGroup() {
    return CacheRepository.isCFlag(ClientFlag.enableDepartmentGroup);
  }

  // 是否开启自当离开
  isOpenAutoLeave() {
    return CacheRepository.isCFlag(ClientFlag.autoOffline);
  }
}
