import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// 定义请求状态
class RequestState {
  final String? data;
  final String? error;
  final bool isLoading;

  RequestState({this.data, this.error, this.isLoading = false});
}

// 创建 API 服务
class ApiService {
  final dio = Dio();

  Future<String> submitPost(String title, String body) async {
    try {
      final response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          'title': title,
          'body': body,
          'userId': 1,
        },
      );
      return 'Success: ${response.statusCode}';
    } catch (e) {
      throw Exception('Failed to submit post: $e');
    }
  }
}

class PostNotifier extends StateNotifier<RequestState> {
  final ApiService _apiService;

  PostNotifier(this._apiService) : super(RequestState());

  Future<void> submitPost(String title, String body) async {
    state = RequestState(isLoading: true);
    try {
      final response = await _apiService.submitPost(title, body);
      state = RequestState(data: response);
    } catch (e) {
      state = RequestState(error: e.toString());
    }
  }
}

// 创建 Provider

final postStateProvider = StateNotifierProvider<PostNotifier, RequestState>(
  (ref) => PostNotifier(ref.read(Provider((ref) => ApiService()))),
);

// Widget 实现
class RiverpodNetworkPost extends ConsumerWidget {
  RiverpodNetworkPost({Key? key}) : super(key: key);

  final titleController = TextEditingController(text: "默认标题");
  final bodyController = TextEditingController(text: "默认内容");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod POST 示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: '标题'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: '内容'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: postState.isLoading
                  ? null
                  : () {
                      ref.read(postStateProvider.notifier).submitPost(
                            titleController.text,
                            bodyController.text,
                          );
                    },
              child: postState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('提交'),
            ),
            const SizedBox(height: 16),
            if (postState.data != null)
              Text(
                '成功: ${postState.data}',
                style: const TextStyle(color: Colors.green),
              ),
            if (postState.error != null)
              Text(
                '错误: ${postState.error}',
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
