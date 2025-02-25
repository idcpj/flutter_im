part of 'types.dart';

typedef TcpCallback = Function(Uint8List data);
typedef CmdCallback = Future<void> Function(StaticCode code, Message msg);
