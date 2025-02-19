import 'sdk_exception.dart';

class ArgsException extends SdkException {
  ArgsException(super.message);

  @override
  String toString() => 'ArgsException: $message';
}
