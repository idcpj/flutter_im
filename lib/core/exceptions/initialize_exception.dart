import 'sdk_exception.dart';

class InitializeException extends SdkException {
  InitializeException(String message) : super(message);

  @override
  String toString() => 'InitializeException: $message';
}
