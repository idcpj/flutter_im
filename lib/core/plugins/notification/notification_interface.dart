abstract class NotificationAbstract {
  // 具体实现
  Future<void> initialize();
  Future<void> show({required String title, required String body});
}
