part of 'exceptions.dart';

class NotFoundTypeException extends SdkException {
  NotFoundTypeException(super.message);

  @override
  String toString() => 'NotFoundTypeException: $message';
}
