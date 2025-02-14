import 'sdk_exception.dart';

class CodeMessageException extends SdkException {
  CodeMessageException(String message) : super(message);

  @override
  String toString() => message;
}
