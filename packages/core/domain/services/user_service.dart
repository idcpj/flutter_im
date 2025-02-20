import '../../constants/constants.dart';
import '../../platform/device/device_info.dart';
import '../../helpers/platform.dart';
import '../hook/user_hook.dart';
import 'base_service.dart';

class UserService extends BaseService {
  UserHook? userHook;

  UserService({required super.app}) {
    userHook = UserHook(app);
  }

  Future<void> login(String loginName, String password, String saasName, EnTypeType enType) async {
    final msg = buildMessage(CMD_LOGIN);

    // todo 需要根据平台来判断
    final platform = PlatformCode.getCode(PlatformType.android);
    final updatePlatform = PlatformCode.getCode(PlatformType.android);
    const nLoginFlag = '0';
    final clientVern = await app.getVersion();

    const opType = OpType.loginName;

    msg.addParams(loginName); // strOperatorName
    msg.addParams(saasName); // str
    msg.addParams(platform); //
    msg.addParams(password);
    msg.addParams(enType.toString());
    msg.addParams(nLoginFlag);
    msg.addParams(clientVern);
    msg.addParams(updatePlatform);

    msg.addPropos(PropKeyType.opType, opType);

    if (Platform.isIOS) {
      msg.addParams(PropKeyType.ipushId.value);
    }

    if (Platform.isMobile) {
      // msg.addPropos(
      //   PropKeyType.iVendorId,
      // );
      // msg.addPropos(
      //   PropKeyType.iVendorType,
      // );

      msg.addPropos(
        PropKeyType.userDevice,
        await DeviceInfo.getDeviceId(),
      );
    }

    if (Platform.isDesktop) {
      msg.addPropos(PropKeyType.macAddr, await DeviceInfo.macAddr());
    }

    send(msg);
  }
}
