import 'package:flutter/material.dart';

import '../widgets/flutter_hook.dart';
import '../widgets/riverpod.dart';
import '../widgets/riverpod_network.dart';
import '../widgets/riverpod_obj.dart';

class PackPage extends StatelessWidget {
  const PackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('功能测试页面'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildButton(context, 'flutter_hook', () => const FlutterHook()),
          _buildButton(context, 'riverpod', () => const RiverpodExample()),
          _buildButton(context, 'riverpod_obj', () => const RiverpodObj()),
          _buildButton(
              context, 'riverpod_network', () => const RiverpodNetwork()),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String s, Widget Function() builder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => builder()),
          ),
        },
        child: Text(s),
      ),
    );
  }
}
