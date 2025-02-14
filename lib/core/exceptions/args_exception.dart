import 'sdk_exception.dart';

class ArgsException extends SdkException {
  ArgsException(String message) : super(message);

  @override
  String toString() => 'ArgsException: $message';
}
