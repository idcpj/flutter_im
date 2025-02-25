part of 'repository.dart';

class UserRepository extends BaseRepository {
  static UserRepository? _instance;

  UserRepository._internal();

  factory UserRepository() {
    _instance ??= UserRepository._internal();
    return _instance!;
  }
}
