import 'sdk_exception.dart';

class HttpException extends SdkException {
  HttpException(String message) : super(message);

  @override
  String toString() => 'HttpException: $message';
}
