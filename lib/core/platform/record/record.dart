import 'package:record/record.dart';

class Recorder {
  final _audioRecorder = AudioRecorder();

  /// 开始录音
  /// [path] 录音文件保存路径
  Future<void> start({required String path}) async {
    final config = RecordConfig(
      encoder: AudioEncoder.wav,
      bitRate: 128000,
      sampleRate: 44100,
    );

    await _audioRecorder.start(config, path: path);
  }

  /// 停止录音
  /// 返回录音文件路径
  Future<String?> stop() async {
    return await _audioRecorder.stop();
  }

  /// 取消录音并删除文件
  Future<void> cancel() async {
    await _audioRecorder.cancel();
  }

  /// 暂停录音
  Future<void> pause() async {
    await _audioRecorder.pause();
  }

  /// 继续录音
  Future<void> resume() async {
    await _audioRecorder.resume();
  }

  /// 检查是否正在录音
  Future<bool> isRecording() async {
    return await _audioRecorder.isRecording();
  }

  /// 检查录音是否暂停
  Future<bool> isPaused() async {
    return await _audioRecorder.isPaused();
  }

  /// 检查并请求录音权限
  Future<bool> hasPermission() async {
    return await _audioRecorder.hasPermission();
  }

  /// 获取当前音量大小
  Future<Amplitude> getAmplitude() async {
    return await _audioRecorder.getAmplitude();
  }

  /// 释放录音资源
  Future<void> dispose() async {
    await _audioRecorder.dispose();
  }

  /// 监听录音状态变化
  Stream<RecordState> onStateChanged() => _audioRecorder.onStateChanged();

  /// 监听音量变化
  Stream<Amplitude> onAmplitudeChanged(Duration interval) {
    return _audioRecorder.onAmplitudeChanged(interval);
  }
}
