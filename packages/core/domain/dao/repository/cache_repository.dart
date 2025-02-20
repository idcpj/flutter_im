import '../../../constants/constants.dart';
import '../../../types/types.dart';

class CacheRepository {
  static final Map<String, dynamic> _cache = {};

  static void setCache(String key, dynamic value) {
    _cache[key] = value;
  }

  static T getCache<T>(String key) {
    return _cache[key] as T;
  }

  // 获取私有数据
  static String getPersonConfig(PersonType type) {
    return getCache<String>(type.value);
  }

  //设置私有数据
  static void setPersonConfig(PersonType type, String body) {
    setCache(type.value, body);
  }

  // 客户端系统配置
  static bool isCFlag(ClientFlag n) {
    return ((getCache<ClientFlag>(LoginResKey.cflag.value).value & n.value) == n.value);
  }

  // 查看他人信息权限
  static bool preViewPower(ProfileViewType power) {
    return ((getCache<RolePower>(LoginResKey.roleacexml.value).profileView & power.value) == power.value);
  }

  // 编辑他人信息权限
  static bool profileEditPower(ProfileEditType power) {
    return ((getCache<RolePower>(LoginResKey.roleacexml.value).profileEdit & power.value) == power.value);
  }

  // 消息权限
  static bool msgAce(MsgAceType power) {
    return ((getCache<RolePower>(LoginResKey.roleacexml.value).msgAce & power.value) == power.value);
  }
}
