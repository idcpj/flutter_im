part of 'exceptions.dart';

class SdkException implements Exception {
  final String message;

  SdkException(this.message);

  @override
  String toString() => 'SdkException: $message';
}
