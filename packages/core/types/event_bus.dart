import 'types.dart';

abstract class EventBusAbstract {
  Stream<Message> on(CmdCode cmdCode);
  void emit(CmdCode cmdCode, Message message);
  void off(CmdCode cmdCode);
  void dispose();
}
