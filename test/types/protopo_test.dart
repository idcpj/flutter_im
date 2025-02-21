import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../packages/core/constants/constants.dart';
import '../../packages/core/types/protopo.dart';
import '../../packages/core/constants/enum.dart';

void main() {
  group('解析测试', () {
    test('Param  parse test', () {
      Uint8List uint8list = Uint8List.fromList([
        0x00, 0x00, 0x00, 0x95, // length: 0x95
        0x00, 0x00, 0x00, 0x02, // orderId: 0x02
        0x01, // randomKey1
        0x02, // randomKey2
        0x00, 0x08, // cmd: CmdCode.login (0x0008)
        0x00, // status: StaticCode.normal (0x00)
        0x00, // encry: EncryptCode.none (0x00)
        0x00, 0x00 // reserved: 0x0000
      ]);

      final header = Header.fromBytes(uint8list);

      debugPrint("hedar ${header.cmd}");

      expect(header.length, equals(0x0095));
      expect(header.orderId, equals(0x0002));
      expect(header.randomKey1, equals(0x01));
      expect(header.randomKey2, equals(0x02));
      expect(header.cmd, equals(CmdCode.login));
      expect(header.status, equals(StaticCode.normal));
      expect(header.encry, equals(EncryptCode.none));
      expect(header.reserved, equals(0x0000));
    });
  });

  group("base test", () {
    test("Param  parse test", () {
      List<String> strList = ['aa', '11', '陈鹏杰', '_!'];

      // 使用 UTF-8 编码将字符串转换为字节数组
      final uint8list = Uint8List.fromList(utf8.encode(strList.join(" ")));

      // 验证字节数组的内容
      expect(uint8list[0], equals('a'.codeUnitAt(0))); // 'a'的ASCII码
      expect(uint8list[1], equals('a'.codeUnitAt(0))); // 'a'的ASCII码
      expect(uint8list[2], equals(' '.codeUnitAt(0))); // 空格的ASCII码
      expect(uint8list[3], equals('1'.codeUnitAt(0))); // '1'的ASCII码
      expect(uint8list[4], equals('1'.codeUnitAt(0))); // '1'的ASCII码
      expect(uint8list[5], equals(' '.codeUnitAt(0))); // 空格的ASCII码
      // '陈'的UTF-8编码是3个字节
      expect(uint8list[6], equals(0xE9));
      expect(uint8list[7], equals(0x99));
      expect(uint8list[8], equals(0x88));
      // '鹏'的UTF-8编码是3个字节
      expect(uint8list[9], equals(0xE9));
      expect(uint8list[10], equals(0xB9));
      expect(uint8list[11], equals(0x8F));

      // '杰'的UTF-8编码是3个字节
      expect(uint8list[12], equals(0xE6));
      expect(uint8list[13], equals(0x9D));
      expect(uint8list[14], equals(0xB0));

      expect(uint8list[15], equals(' '.codeUnitAt(0))); // 空格的ASCII码
      expect(uint8list[16], equals('_'.codeUnitAt(0))); // '_'的ASCII码
      expect(uint8list[17], equals('!'.codeUnitAt(0))); // '!'的ASCII码

      // 从字节数组解码回字符串
      final decodedString = utf8.decode(uint8list);
      expect(decodedString, equals('aa 11 陈鹏杰 _!'));
    });

    test("prop parse test", () {
      Map<String, String> prop = {
        'key1': '陈鹏杰',
        'key2': 'aaa',
        'key3': 'bbb^&*',
      };

      String tmp =
          prop.entries.map((entry) => '${entry.key}:${entry.value}').join("\n");

      Uint8List uint8list = Uint8List.fromList(utf8.encode(tmp));

      String decodedString = utf8.decode(uint8list);

      expect(decodedString, equals("key1:陈鹏杰\nkey2:aaa\nkey3:bbb^&*"));
    });
  });

  group('ProtoHeader Tests', () {
    test('默认构造函数测试', () {
      final header = Header();
      expect(header.length, equals(0x0010));
      expect(header.orderId, equals(0x0001));
      expect(header.cmd, equals(0x0010));
      expect(header.status, equals(StaticCode.normal));
      expect(header.encry, equals(EncryptCode.none));
    });

    test('ProtoHeader 序列化和反序列化测试', () {
      final header = Header(
        length: 100,
        orderId: 1234,
        randomKey1: 0x11,
        randomKey2: 0x22,
        cmd: CmdCode.login,
        status: StaticCode.error,
        encry: EncryptCode.aes256,
      );

      final bytes = header.toBytes();
      final decoded = Header.fromBytes(bytes);

      expect(decoded.length, equals(100));
      expect(decoded.orderId, equals(1234));
      expect(decoded.randomKey1, equals(0x11));
      expect(decoded.randomKey2, equals(0x22));
      expect(decoded.cmd, equals(0x0020));
      expect(decoded.status, equals(StaticCode.error));
      expect(decoded.encry, equals(EncryptCode.aes256));
    });
  });

  group('Message Tests', () {
    test('完整消息测试', () {
      final message = Message(
        header: Header(),
        params: ['param1', 'param2', 'param3'],
        props: {'prop1': 'value1', 'prop2': 'value2'},
        body: 'Hello World',
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, equals(['param1', 'param2', 'param3']));
      expect(decoded.props, equals({'prop1': 'value1', 'prop2': 'value2'}));
      expect(decoded.body, equals('Hello World'));
    });

    test('只有参数的消息测试', () {
      final message = Message(
        header: Header(),
        params: ['param1', 'param2'],
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, equals(['param1', 'param2']));
      expect(decoded.props, isNull);
      expect(decoded.body, isNull);
    });

    test('只有属性的消息测试', () {
      final message = Message(
        header: Header(),
        props: {'key1': 'value1'},
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, isNull);
      expect(decoded.props, equals({'key1': 'value1'}));
      expect(decoded.body, isNull);
    });

    test('只有消息体的消息测试', () {
      final message = Message(
        header: Header(),
        body: 'test body',
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, isNull, reason: 'params not empty');
      expect(decoded.props, isNull, reason: 'props not empty');
      expect(decoded.body, equals('test body'), reason: 'body is empty');
    });

    test('空消息测试', () {
      final message = Message(
        header: Header(),
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, isNull);
      expect(decoded.props, isNull);
      expect(decoded.body, isNull);
    });

    test('特殊字符测试', () {
      final message = Message(
        header: Header(),
        params: ['特殊字符!@#', '中文测试'],
        props: {'特殊键': '特殊值!@#'},
        body: '包含换行\n和特殊字符!@#\$%^',
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params, equals(['特殊字符!@#', '中文测试']));
      expect(decoded.props, equals({'特殊键': '特殊值!@#'}));
      expect(decoded.body, equals('包含换行\n和特殊字符!@#\$%^'));
    });

    test('长消息测试', () {
      final longString = 'a' * 1000;
      final message = Message(
        header: Header(),
        params: [longString],
        props: {'long': longString},
        body: longString,
      );

      final bytes = message.toBytes();
      final decoded = Message.fromBytes(bytes);

      expect(decoded.params?[0].length, equals(1000));
      expect(decoded.props?['long']?.length, equals(1000));
      expect(decoded.body?.length, equals(1000)); // 包含两个换行符
    });
  });
}
