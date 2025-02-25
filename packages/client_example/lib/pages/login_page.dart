import 'package:core/bin/mobile_app.dart';
import 'package:core/constants/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final app = MobileApp();
  String? userName; // 用于存储用户名
  Map<String, dynamic>? userInfo; // 用于存储用户信息

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
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await app.userService.dbGetUserById(app.userId());
                  if (context.mounted) {
                    setState(() {
                      userInfo = user?.toMap();
                    });
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('获取用户信息失败: $e')),
                    );
                  }
                }
              },
              child: const Text('获取用户信息'),
            ),
            if (userInfo != null) // 如果用户信息不为空，则显示
              Column(
                children: [
                  Text('用户信息:', style: TextStyle(fontSize: 20)),
                  Text('人员id: ${userInfo?['user_id']}', style: TextStyle(fontSize: 20)),
                  Text('人员登录: ${userInfo?['user_login']}', style: TextStyle(fontSize: 20)),
                  Text('人员名称: ${userInfo?['user_name']}', style: TextStyle(fontSize: 20)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
