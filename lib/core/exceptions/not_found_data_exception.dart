import 'sdk_exception.dart';

class NotFoundDataException extends SdkException {
  NotFoundDataException(super.message);

  @override
  String toString() => 'NotFoundDataException: $message';
}
