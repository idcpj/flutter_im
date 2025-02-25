part of 'repository.dart';

class ConfigRepository extends BaseRepository {
  static ConfigRepository? _instance;

  ConfigRepository._();

  factory ConfigRepository() {
    _instance ??= ConfigRepository._();
    return _instance!;
  }
}
