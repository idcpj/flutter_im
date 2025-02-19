import 'sdk_exception.dart';

class CodeMessageException extends SdkException {
  CodeMessageException(super.message);

  @override
  String toString() => message;
}
