import 'dart:typed_data';

import 'types.dart';

typedef TcpCallback = Function(Uint8List data);
typedef CmdCallback = Function(int code, Message data);
