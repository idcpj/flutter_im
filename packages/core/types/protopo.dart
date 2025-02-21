import 'dart:convert';
import 'dart:typed_data';

import '../constants/constants.dart';

/// 协议头定义 - 固定16字节
class Header {
  /// 数据包长度 (4字节) - 整个数据包的长度(包含头部)
  int length; // uint32

  /// 序号/命令ID (4字节)
  int orderId; // uint32

  /// 随机密钥1 (1字节)
  int randomKey1; // uint8

  /// 随机密钥2 (1字节)
  int randomKey2; // uint8

  /// 命令类型 (2字节)
  CmdCode cmd; // uint16

  /// 状态码 (1字节)
  /// 0: 正常
  /// 1: 出错
  /// 2: 命令未完成
  /// 3: 命令需要ACK
  StaticCode status; // uint8

  /// 加密方式 (1字节)
  /// 0: 无加密
  /// 1: AES256
  /// 2: SM4
  EncryptCode encry; // uint8

  /// 预留字段 (2字节)
  int reserved; // uint16

  Header({
    this.length = 0,
    this.orderId = 0,
    this.randomKey1 = 0x10,
    this.randomKey2 = 0x01,
    this.cmd = CmdCode.login,
    this.status = StaticCode.normal,
    this.encry = EncryptCode.none,
    this.reserved = 0x0000,
  });

  /// 将协议头转换为字节数组
  Uint8List toBytes() {
    final bytes = Uint8List(16);
    final byteData = ByteData.view(bytes.buffer);

    // 写入包长度 (4字节)
    byteData.setUint32(0, length);

    // 写入序号 (4字节)
    byteData.setUint32(4, orderId);

    // 写入随机密钥 (2字节)
    byteData.setUint8(8, randomKey1);
    byteData.setUint8(9, randomKey2);

    // 写入命令 (2字节)
    byteData.setUint16(10, cmd.value);
    // 写入状态码 (1字节)
    byteData.setUint8(12, status.index);

    // 写入加密方式 (1字节)
    byteData.setUint8(13, encry.index);

    // 写入预留字段 (2字节)
    byteData.setUint16(14, reserved);

    return bytes;
  }

  /// 从字节数组构造协议头
  factory Header.fromBytes(Uint8List bytes) {
    ByteData byteData = ByteData.view(bytes.buffer);

    final res = byteData.getUint16(10, Endian.big);

    return Header(
      length: byteData.getUint32(0, Endian.big), // 读取前4字节作为length
      orderId: byteData.getUint32(4, Endian.big), // 读取接下来4字节作为orderId
      randomKey1: bytes[8], // 第9字节作为randomKey1
      randomKey2: bytes[9], // 第10字节作为randomKey2
      cmd: CmdCode.values[byteData.getUint16(10, Endian.big)], // 读取接下来2字节作为cmd
      status: StaticCode.values[bytes[12]], // 第13字节作为status
      encry: EncryptCode.values[bytes[13]], // 第14字节作为encry
      reserved: byteData.getUint16(14, Endian.big), // 最后2字节作为reserved
    );
  }
}

/// 协议消息体定义
class Message {
  /// 协议头
  final Header _header;

  /// 参数数组 - 可选
  List<String>? _params;

  /// 属性字典 - 可选, String 类型只能用 PropKeyType
  Map<String, String>? _props;

  /// 消息体 - 可选
  String? body;

  Message({
    required Header header,
    List<String>? params,
    Map<String, String>? props,
    this.body,
  })  : _props = props,
        _params = params,
        _header = header;

  /// 将消息转换为字节数组
  Uint8List toBytes() {
    // 先转换header
    final headerBytes = _header.toBytes();

    // 转换params + 换行符
    final paramsBytes = _encodeParams() + Uint8List.fromList([0x0A]);

    // 转换props
    final propsBytes = _encodeProps() + Uint8List.fromList([0x0A]);

    // 转换body (添加两个空行的分隔)
    var endBytes = Uint8List(0); // 结尾字节,如果不存在body加一个换行
    var bodyBytes = _encodeBody();
    if (bodyBytes.isNotEmpty) {
      bodyBytes = Uint8List.fromList([0x0A, ...bodyBytes]);
    } else {
      endBytes = Uint8List.fromList([0x0A]);
    }

    // 合并所有字节
    final result = Uint8List(headerBytes.length + paramsBytes.length + propsBytes.length + bodyBytes.length + endBytes.length);

    result.setAll(0, headerBytes);
    result.setAll(headerBytes.length, paramsBytes);
    result.setAll(headerBytes.length + paramsBytes.length, propsBytes);
    result.setAll(headerBytes.length + paramsBytes.length + propsBytes.length, bodyBytes);
    result.setAll(headerBytes.length + paramsBytes.length + propsBytes.length + bodyBytes.length, endBytes);

    // 更新包长度
    final byteData = ByteData.view(result.buffer);
    byteData.setUint32(0, result.length);

    return result.buffer.asByteData().buffer.asUint8List();
  }

  /// 从字节数组构造消息
  static Message fromBytes(Uint8List bytes) {
    if (bytes.length < 16) {
      throw Exception('Invalid message length');
    }

    // 解析header
    final header = Header.fromBytes(bytes);

    // 解析剩余数据
    var content = utf8.decode(bytes.sublist(16));
    final lines = content.split('\n');

    List<String>? params;
    Map<String, String>? props;
    String? body;

    int currentLine = 0;

    // 解析第一行作为params (如果不为空且不包含冒号)
    if (lines.isNotEmpty && lines[0].trim().isNotEmpty && !lines[0].contains(':')) {
      params = lines[0].trim().split(' ');
    }
    currentLine++;

    // 解析props (包含冒号的行)
    while (currentLine < lines.length) {
      final line = lines[currentLine].trim();
      if (line.isEmpty) break; // 遇到空行停止解析props

      if (line.contains(':')) {
        if (props == null) props = {};
        final colonIndex = line.indexOf(':');
        final key = line.substring(0, colonIndex).trim();
        final value = line.substring(colonIndex + 1).trim();
        props[key] = value;
        currentLine++;
      } else {
        break;
      }
    }

    // 跳过空行
    while (currentLine < lines.length && lines[currentLine].trim().isEmpty) {
      currentLine++;
    }

    // 解析剩余内容作为body
    if (currentLine < lines.length) {
      final bodyLines = lines.sublist(currentLine);
      final bodyContent = bodyLines.join('\n').trim();
      if (bodyContent.isNotEmpty) {
        body = bodyContent;
      }
    }

    return Message(
      header: header,
      params: params,
      props: props,
      body: body,
    );
  }

  /// 编码params为字节数组
  Uint8List _encodeParams() {
    if (_params == null || _params!.isEmpty) {
      return Uint8List(0);
    }
    return Uint8List.fromList(utf8.encode(_params!.join(" ")));
  }

  /// 编码props为字节数组
  Uint8List _encodeProps() {
    if (_props == null || _props!.isEmpty) {
      return Uint8List(0);
    }

    return Uint8List.fromList(utf8.encode(_props!.entries.map((entry) => '${entry.key}:${entry.value}').join("\n")));
  }

  /// 编码body为字节数组
  Uint8List _encodeBody() {
    if (body == null || body!.isEmpty) {
      return Uint8List(0);
    }

    return Uint8List.fromList(utf8.encode(body!));
  }

  get header => _header;
  get params => _params;
  get props => _props;

  void addParams(dynamic item) {
    _params ??= [];
    _params!.add(item.toString());
  }

  void addPropos(PropKeyType key, dynamic val) {
    _props ??= {};
    if (_props?[key.value] != null) {
      throw ArgumentError("props key already exists");
    }
    _props?[key.value] = val.toString();
    if (key == "body") {
      _props?['content-length'] = utf8.encode(val.toString()).length.toString();
    }
  }

  void setBody(String body) {
    _props?['body'] = body;
    _props?['content-length'] = utf8.encode(body).length.toString();
  }
}
