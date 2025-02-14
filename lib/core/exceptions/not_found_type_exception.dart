import 'sdk_exception.dart';

class NotFoundTypeException extends SdkException {
  NotFoundTypeException(String message) : super(message);

  @override
  String toString() => 'NotFoundTypeException: $message';
}
