import 'package:core/constants/constants.dart';
import 'package:core/exceptions/exceptions.dart';
import 'package:core/types/types.dart';

abstract class BaseHook {
  AppAbstract app;

  BaseHook(this.app);

  void checkCode(StaticCode code, Message data) {
    if (code != StaticCode.normal) {
      throw SdkException(/* 
          ErrorCodes.getMessage(code) + */
          "  cmd=" + data.header.cmd);
    }
  }

  bool checkCodeNotException(StaticCode code) {
    if (code != StaticCode.normal) {
      return false;
    }
    return true;
  }
}
