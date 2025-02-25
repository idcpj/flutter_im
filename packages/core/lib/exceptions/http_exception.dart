part of 'exceptions.dart';

class HttpException extends SdkException {
  HttpException(super.message);

  @override
  String toString() => 'HttpException: $message';
}
