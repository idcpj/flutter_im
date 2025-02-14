import 'sdk_exception.dart';

class NotFoundDataException extends SdkException {
  NotFoundDataException(String message) : super(message);

  @override
  String toString() => 'NotFoundDataException: $message';
}
