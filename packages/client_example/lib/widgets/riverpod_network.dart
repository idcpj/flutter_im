import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// 模拟成功的网络请求
final successProvider = FutureProvider<String>((ref) async {
  // 模拟网络延迟
  await Future.delayed(const Duration(seconds: 2));
  return '请求成功，获取到数据!';
});

// 模拟失败的网络请求
final failureProvider = FutureProvider<String>((ref) async {
  // 模拟网络延迟
  await Future.delayed(const Duration(seconds: 2));
  throw Exception('网络请求失败!');
});

class RiverpodNetwork extends ConsumerWidget {
  const RiverpodNetwork({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final successRequest = ref.watch(successProvider);
    final failureRequest = ref.watch(failureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 网络请求示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 成功请求的展示
            successRequest.when(
              data: (data) => Text(data),
              error: (error, stack) => Text('错误: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            // 失败请求的展示

            failureRequest.when(
              data: (data) => Text(data),
              error: (error, stack) => Text('错误: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
