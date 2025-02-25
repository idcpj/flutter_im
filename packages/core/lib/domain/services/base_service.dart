import 'dart:math';

import 'package:core/constants/constants.dart';
import 'package:core/types/types.dart';

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
      header: Header(
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
