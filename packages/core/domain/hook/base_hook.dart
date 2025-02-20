import '../../constants/constants.dart';
import '../../exceptions/exceptions.dart';
import '../../types/types.dart';

abstract class BaseHook {
  AppAbstract app;

  BaseHook(this.app);

  void checkCode(int code, Message data, need) {
    if (code != 0) {
      throw SdkException(ErrorCodes.getMessage(code) + "  cmd=" + data.header.cmd);
    }
  }

  bool checkCodeNotException(int code) {
    if (code != 0) {
      return false;
    }
    return true;
  }
}
