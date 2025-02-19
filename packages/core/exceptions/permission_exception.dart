import 'sdk_exception.dart';

class PermissionException extends SdkException {
  PermissionException(super.message);

  @override
  String toString() => 'PermissionException: $message';
}
