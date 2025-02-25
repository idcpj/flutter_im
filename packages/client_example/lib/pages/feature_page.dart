import 'package:core/platform/geolocator/geolocator.dart';
import 'package:core/platform/log/log.dart';
import 'package:core/platform/notification/notification.dart';
import 'package:core/types/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../tools/database_helper.dart';
import 'record_page.dart';

class FeaturePage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final _notificationHelper = NotificationPlatform.instance;
  final _logHelper = LogPlatform();
  final _geolocatorHelper = GeolocatorPlatform.instance;

  FeaturePage({super.key}) {
    _logHelper.initialization("tmp", LogLevel.debug);
    _notificationHelper.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('功能测试页面'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildButton(context, '录音测试', (context) async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecordPage()),
            );
          }),
          _buildButton(context, '初始化数据库', _initDb),
          _buildButton(context, '插入数据', _insertDb),
          _buildButton(context, '查询数据', _queryDb),
          _buildButton(context, 'WebSocket 测试', _testWebSocket),
          _buildButton(context, 'SharedPreferences 测试', _testSharedPreferences),
          _buildButton(context, '调用相机', _openCamera),
          _buildButton(context, '调用相册', _openGallery),
          _buildButton(context, '获取定位', _getLocation),
          _buildButton(context, '文件下载', _downloadFile),
          _buildButton(context, '调用文件', _pickFile),
          _buildButton(context, '通知测试', _testNotification),
          _buildButton(context, '日志测试', _testLog),
        ],
      ),
    );
  }

  Future<void> _testLog(BuildContext context) async {
    _logHelper.debug('测试日志 debug');
    _logHelper.info('测试日志 info');
    _logHelper.warning('测试日志 warning');
    _logHelper.error('测试日志 error');
    _logHelper.critical('测试日志 critical');
  }

  Future<void> _initDb(BuildContext context) async {
    try {
      await DatabaseHelper.initializeDatabase();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('数据库初始化成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('数据库初始化失败: $e')),
      );
    }
  }

  Future<void> _insertDb(BuildContext context) async {
    try {
      await dbHelper.createPerson('张三', 20);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('数据库插入成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('数据库插入失败: $e')),
      );
    }
  }

  Future<void> _queryDb(BuildContext context) async {
    try {
      final people = await dbHelper.getAllPeople();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('数据库查询成功: ${people.length}条数据')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('数据库查询失败: $e')),
      );
    }
  }

  Widget _buildButton(BuildContext context, String text, Future<void> Function(BuildContext) onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(text),
        ),
      ),
    );
  }

  Future<void> _testNotification(BuildContext context) async {
    await _notificationHelper.show(
      title: '测试通知',
      body: '这是测试通知内容',
    );
  }

  Future<void> _testWebSocket(BuildContext context) async {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );

    try {
      await channel.ready;
      channel.sink.add('测试消息');

      final response = await channel.stream.first;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('收到WebSocket响应: $response')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('WebSocket错误: $e')),
      );
    } finally {
      channel.sink.close();
    }
  }

  Future<void> _testSharedPreferences(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('testCounter', DateTime.now().second);
    final value = prefs.getInt('testCounter');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('SharedPreferences存储值: $value')),
    );
  }

  Future<void> _openCamera(BuildContext context) async {
    if (!await _requestPermission(Permission.camera, context)) return;

    final cameras = await availableCameras();
    final controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );

    await controller.initialize();
    // 这里可以跳转到相机预览页面

    debugPrint('相机预览页面');

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('相机预览')),
          body: Stack(
            children: [
              CameraPreview(controller),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final image = await controller.takePicture();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('照片已保存: ${image.path}')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('拍照失败: $e')),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text('拍照'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await controller.dispose();
  }

  Future<void> _openGallery(BuildContext context) async {
    final deviceInfo = DeviceInfoPlugin();
    final permission = Platform.isAndroid && await deviceInfo.androidInfo.then((info) => info.version.sdkInt >= 33) ? Permission.photos : Permission.storage;

    if (!await _requestPermission(permission, context)) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已选择图片: ${image.path}')),
      );
    }
  }

  Future<void> _getLocation(BuildContext context) async {
    debugPrint('触发 获取位置');
    // if (!await _requestPermission(Permission.location, context)) return;

    try {
      final position = await _geolocatorHelper.getCurrentPosition();

      debugPrint('当前位置: ${position.latitude}, ${position.longitude}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('当前位置: ${position.latitude}, ${position.longitude}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('获取位置失败: $e')),
      );
    }
  }

  Future<void> _downloadFile(BuildContext context) async {
    if (!await _requestPermission(Permission.storage, context)) return;

    try {
      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/test_download.jpg';

      await dio.download(
        'https://picsum.photos/200/300',
        path,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('文件已下载到: $path')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('下载失败: $e')),
      );
    }
  }

  Future<void> _pickFile(BuildContext context) async {
    // 在 Web 平台上不需要存储权限
    if (!kIsWeb && !await _requestPermission(Permission.storage, context)) {
      return;
    }

    try {
      // 配置 FileType 和 允许的文件扩展名
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        // 支持所有文件类型，也可以指定具体类型如：
        // allowedExtensions: ['jpg', 'pdf', 'doc'],
        // withData: true, // Web平台需要设置为true来获取文件数据
        // withReadStream: true, // 用于处理大文件
      );

      if (result != null) {
        if (kIsWeb) {
          // Web 平台处理
          final files = result.files;
          String fileInfo = '已选择 ${files.length} 个文件\n';
          fileInfo += '首个文件名: ${files.first.name}, 大小: ${files.first.size} 字节';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(fileInfo),
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          // 移动端和桌面端处理
          List<File> files = result.paths.where((path) => path != null).map((path) => File(path!)).toList();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('已选择 ${files.length} 个文件\n首文件: ${files.first.path}'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('文件选择失败: $e')),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission, BuildContext context) async {
    if (await permission.isGranted) {
      return true;
    }

    final status = await permission.request();

    if (status.isPermanentlyDenied) {
      // 引导用户前往设置开启权限
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('需要权限'),
          content: const Text('请在设置中开启相册访问权限'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings();
                Navigator.pop(context);
              },
              child: const Text('去设置'),
            ),
          ],
        ),
      );
      return false;
    }

    return status.isGranted;
  }
}
