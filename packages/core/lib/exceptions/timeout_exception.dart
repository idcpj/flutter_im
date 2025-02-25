part of 'exceptions.dart';

class TimeoutException extends SdkException {
  TimeoutException(super.message);

  @override
  String toString() => 'TimeoutException: $message';
}
