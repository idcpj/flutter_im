import 'dart:typed_data';

import 'types.dart';

typedef CmdCode = int; //2 个字节  uint16
typedef TcpCallback = Function(Uint8List data);
typedef CmdCallback = Function(int code, Message data);
