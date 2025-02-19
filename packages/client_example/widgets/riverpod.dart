import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 创建一个简单的 Provider
final counterProvider = Provider<int>((ref) => 42);

// 创建一个可变的 StateProvider
final nameProvider = StateProvider<String>((ref) => '张三');

// 创建一个异步的 FutureProvider
final userDataProvider = FutureProvider<String>((ref) async {
  // 模拟网络请求
  await Future.delayed(const Duration(seconds: 2));
  return '从服务器获取的用户数据';
});

class RiverpodExample extends ConsumerWidget {
  const RiverpodExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听 Provider 的值
    final counter = ref.watch(counterProvider);
    final name = ref.watch(nameProvider);

    // 监听异步数据
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('计数器值: $counter'),
            const SizedBox(height: 20),
            Text('当前名字: $name'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 修改 StateProvider 的值
                ref.read(nameProvider.notifier).state = '李四';
              },
              child: const Text('修改名字'),
            ),
            const SizedBox(height: 20),
            // 处理异步数据的显示
            userData.when(
              data: (data) => Text('用户数据: $data'),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('错误: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
