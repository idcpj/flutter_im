import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// 一个使用 Hook 的计数器示例组件
class FlutterHook extends HookWidget {
  const FlutterHook({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 useState 管理状态
    final counter = useState(0);

    // 使用 useEffect 处理副作用
    useEffect(() {
      print('组件已挂载');
      return () {
        print('组件将要卸载');
      };
    }, []); // 空数组表示只在组件挂载和卸载时执行

    // 使用 useMemoized 缓存计算结果
    final doubledCount = useMemoized(() => counter.value * 2, [counter.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hooks 示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '点击次数: ${counter.value}',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '双倍值: $doubledCount',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('增加'),
            ),
          ],
        ),
      ),
    );
  }
}

// 自定义 Hook 示例
T useCustomDebounce<T>(T value, Duration delay) {
  final valueState = useState(value);

  useEffect(() {
    final timer = Future.delayed(delay, () {
      valueState.value = value;
    });
    return () => timer.ignore();
  }, [value, delay]);

  return valueState.value;
}
