import 'sdk_exception.dart';

class TimeoutException extends SdkException {
  TimeoutException(super.message);

  @override
  String toString() => 'TimeoutException: $message';
}
