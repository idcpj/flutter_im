part of 'exceptions.dart';

class ConnectException extends SdkException {
  ConnectException(super.message);

  @override
  String toString() => 'ConnectException: $message';
}
