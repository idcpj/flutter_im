import 'sdk_exception.dart';

class HttpException extends SdkException {
  HttpException(super.message);

  @override
  String toString() => 'HttpException: $message';
}
