import 'sdk_exception.dart';

class TimeoutException extends SdkException {
  TimeoutException(String message) : super(message);

  @override
  String toString() => 'TimeoutException: $message';
}
