part of 'exceptions.dart';

class PermissionException extends SdkException {
  PermissionException(super.message);

  @override
  String toString() => 'PermissionException: $message';
}
