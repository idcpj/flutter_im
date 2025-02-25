// 定义 Todo 类
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Todo {
  final String id;
  final String title;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

// 创建 TodosNotifier
class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          Todo(id: '1', title: '学习 Flutter'),
          Todo(id: '2', title: '学习 Riverpod'),
          Todo(id: '3', title: '完成项目'),
        ]);

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }
}

// 创建 StateNotifierProvider
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

class RiverpodObj extends ConsumerWidget {
  const RiverpodObj({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ... existing code ...

    // 获取 todos 列表
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... existing code ...

            const SizedBox(height: 20),
            Text('已完成${todos.where((todo) => todo.completed).length}'),
            const SizedBox(height: 20),
            const Text('待办事项:'),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (_) {
                        // 切换待办事项的完成状态
                        ref.read(todosProvider.notifier).toggleTodo(todo.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
