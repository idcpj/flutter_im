import 'dart:math';

import '../../constants/constants.dart';
import '../../types/types.dart';

abstract class BaseService {
  AppAbstract app;

  static int _order = 1;
  static EncryptCode _encry = EncryptCode.none; // 0-无操作；1- AES256；2-国产的SM4

  BaseService({required this.app});

  int get order {
    _order++;
    return _order;
  }

  EncryptCode get encry {
    return _encry;
  }

  set encry(EncryptCode value) {
    _encry = value;
  }

  int secretKey() {
    return Random().nextInt(255);
  }

  Message buildMessage(CmdCode cmd) {
    return Message(
      header: ProtoHeader(
        cmd: cmd,
        orderId: order,
        encry: encry,
        randomKey1: secretKey(),
        randomKey2: secretKey(),
      ),
    );
  }

  send(Message data) {
    app.send(data);
  }
}
