import 'package:flutter/material.dart';

import '../../core/bin/mobile_app.dart';
import '../../core/constants/constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final app = MobileApp();

  @override
  Widget build(BuildContext context) {
    app.initialize();

    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // 这里调用登录方法
              // 假设你有一个 MobileApp.login() 方法
              await app?.connect(host: 'bg.jiuqitech.cn', port: 6661, domain: 'jiuqi');

              app?.userService.login('liuy', '123456', 'jiuqi', EnTypeType.aten);
            } catch (e) {
              // 显示错误提示
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('登录失败: $e')),
                );
              }
            }
          },
          child: const Text('登录'),
        ),
      ),
    );
  }
}
