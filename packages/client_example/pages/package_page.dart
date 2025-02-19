import 'package:flutter/material.dart';

import '../widgets/flutter_hook.dart';
import '../widgets/riverpod_example.dart';
import '../widgets/riverpod_example_annotaion.dart';
import '../widgets/riverpod_network.dart';
import '../widgets/riverpod_network_annotaion.dart';
import '../widgets/riverpod_network_post.dart';
import '../widgets/riverpod_network_post_annotation.dart';
import '../widgets/riverpod_obj.dart';
import '../widgets/riverpod_obj_annotation.dart';

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
              context, 'riverpod_network_get', () => const RiverpodNetwork()),
          _buildButton(
              context, 'riverpod_network_post', () => RiverpodNetworkPost()),
          // annotation
          _buildButton(context, 'riverpod_annotation',
              () => const RiverpodExampleAnnotaion()),

          _buildButton(context, 'riverpod_obj_annotation',
              () => const RiverpodObjAnnotation()),

          _buildButton(context, 'riverpod_obj_get_annotation',
              () => const RiverpodNetworkAnnotation()),

          _buildButton(context, 'riverpod_obj_post_annotation',
              () => RiverpodNetworkPostAnnotation()),
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
