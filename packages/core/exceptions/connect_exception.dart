import 'sdk_exception.dart';

class ConnectException extends SdkException {
  ConnectException(super.message);

  @override
  String toString() => 'ConnectException: $message';
}
