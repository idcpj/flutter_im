part of 'exceptions.dart';

class CodeException extends SdkException {
  final int code;

  CodeException(this.code) : super(code.toString());

  @override
  String toString() => 'CodeException: ${ErrorCodes.getMessage(code)}';
}
