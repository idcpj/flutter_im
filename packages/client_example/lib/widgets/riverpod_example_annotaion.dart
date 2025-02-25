import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 需要添加这一行来生成代码
part 'riverpod_example_annotaion.g.dart';

// 使用注解方式定义 Provider
@riverpod
int counter(Ref ref) => 42;

@riverpod
class Name extends _$Name {
  @override
  String build() => '张三';

  void changeName(String newName) {
    state = newName;
  }
}

@riverpod
Future<String> userData(Ref ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return '从服务器获取的用户数据';
}

class RiverpodExampleAnnotaion extends ConsumerWidget {
  const RiverpodExampleAnnotaion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final name = ref.watch(nameProvider);
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
                // 使用 NotifierProvider 的方法来修改状态
                ref.read(nameProvider.notifier).changeName('李四');
              },
              child: const Text('修改名字'),
            ),
            const SizedBox(height: 20),
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
