part of 'exceptions.dart';

class InitializeException extends SdkException {
  InitializeException(super.message);

  @override
  String toString() => 'InitializeException: $message';
}
