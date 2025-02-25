import 'package:flutter/material.dart';

import '../../core/bin/mobile_app.dart';
import '../../core/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final app = MobileApp();
  String? userName; // 用于存储用户名

  @override
  Widget build(BuildContext context) {
    app.initialize();

    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await app.connect(host: 'bg.jiuqitech.cn', port: 6661, domain: 'jiuqi');

                  app.listen(CmdCode.login, (code, data) async {
                    final newUserName = data.params[3];
                    setState(() {
                      userName = newUserName; // 更新用户名
                    });
                    print('用户名: $newUserName');
                  });

                  app.userService.login('liuy', '123456', 'jiuqi', EnTypeType.aten);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('登录失败: $e')),
                    );
                  }
                }
              },
              child: const Text('登录'),
            ),
            if (userName != null) // 如果用户名不为空，则显示
              Text('欢迎, $userName!', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
