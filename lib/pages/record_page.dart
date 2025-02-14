import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool showPlayer = false;
  String? audioPath;
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // 获取应用文档目录保存音频文件
        final dir = await getApplicationDocumentsDirectory();
        final filePath =
            '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';

        // 开始录音
        await _audioRecorder.start(
          RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: filePath,
        );

        setState(() {
          _isRecording = true;
          audioPath = filePath;
          showPlayer = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('开始录音')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('录音失败: $e')),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() => _isRecording = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('录音已保存: ${path ?? "未知路径"}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('停止录音失败: $e')),
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: showPlayer
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(audioPath ?? ''),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: !_isRecording ? _startRecording : null,
                      child: const Text('开始录音'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isRecording ? _stopRecording : null,
                      child: const Text('停止录音'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
