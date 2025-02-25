import 'dart:convert';

import 'package:xml/xml.dart';

import 'package:core/types/types.dart';

Map<String, String> parseUserInfoXml(String xml) {
  final document = XmlDocument.parse(xml);
  final result = <String, String>{};

  // 获取所有 i 标签
  final items = document.findAllElements('i');
  for (var item in items) {
    // 获取s1属性作为key
    final key = item.getAttribute('s1') ?? '';
    // 获取CDATA内容或普通文本内容作为value
    final value = item.innerText;
    result[key] = value;
  }

  return result;
}

List<Map<String, String>> parseAddinListXml(String xml) {
  final document = XmlDocument.parse(xml);
  final result = <Map<String, String>>[];

  // 获取所有 a 标签
  final items = document.findAllElements('a');
  for (var item in items) {
    final map = <String, String>{};
    // 获取所有属性(s1到s21)
    for (var attr in item.attributes) {
      map[attr.name.local] = attr.value;
    }
    result.add(map);
  }

  return result;
}

List<Map<String, String>> parseGroupListXml(String xml) {
  final document = XmlDocument.parse(xml);
  final result = <Map<String, String>>[];

  // 获取所有 g 标签
  final items = document.findAllElements('g');
  for (var item in items) {
    final map = <String, String>{};
    // 获取所有属性
    for (var attr in item.attributes) {
      map[attr.name.local] = attr.value;
    }

    // 获取子元素的值
    for (var child in item.children) {
      if (child is XmlElement) {
        // 对于s17标签特殊处理,因为有两个同名标签
        if (child.name.local == 's17') {
          map['s17_1'] = child.innerText;
        } else {
          map[child.name.local] = child.innerText;
        }
      }
    }
    result.add(map);
  }

  return result;
}

List<Map<String, String>> parseGroupMember(String xml) {
  final document = XmlDocument.parse(xml);
  final result = <Map<String, String>>[];

  // 获取所有 u 标签
  final items = document.findAllElements('u');
  for (var item in items) {
    final map = <String, String>{};
    // 获取所有属性
    for (var attr in item.attributes) {
      map[attr.name.local] = attr.value;
    }
    result.add(map);
  }

  return result;
}

(List<String>, Map<String, String>) parseMessageJson(String body) {
  final params = <String>[];
  final props = <String, String>{};

  // 按行分割
  final lines = body.split('\n');

  // 如果第一行包含空格,说明是参数行
  if (lines[0].contains(' ')) {
    params.addAll(lines[0].trim().split(' '));
    lines.removeAt(0);
  }

  var bodyContent = '';
  var isBody = false;

  // 处理剩余行
  for (var line in lines) {
    line = line.trim();
    if (line.isEmpty) {
      isBody = true;
      continue;
    }

    if (isBody) {
      // 收集body内容
      if (bodyContent.isNotEmpty) {
        bodyContent += '\n';
      }
      bodyContent += line;
    } else {
      // 解析属性行
      final colonIndex = line.indexOf(':');
      if (colonIndex > 0) {
        final key = line.substring(0, colonIndex).trim();
        final value = line.substring(colonIndex + 1).trim();
        props[key] = value;
      }
    }
  }

  // 如果有body内容,添加到props中
  if (bodyContent.isNotEmpty) {
    props['body'] = bodyContent;
  }

  return (params, props);
}

///
///  <l>
///   <f s1='CLIENT'>
///     <i s1='attach_size_limit' s2='8192' s3='1'/>
///     <i s1='batch_person_limit' s2='1000' s3='1'/>
///     <i s1='board_ace' s2='0' s3='0'/>
///     <i s1='msg_ace' s2='128' s3='0'/>
///     <i s1='net_speed_download_limit' s2='' s3='1'/>
///     <i s1='net_speed_upload_limit' s2='' s3='1'/>
///     <i s1='order_system' s2='0' s3='1'/>
///     <i s1='profile_edit' s2='13' s3='0'/>
///     <i s1='profile_view' s2='191' s3='0'/>
///   </f>
/// </l>
///
///
RolePower parseRoleXml(String xml) {
  var rolePower = RolePower();

  if (xml.isEmpty) {
    return rolePower;
  }

  try {
    var doc = XmlDocument.parse(xml);
    var items = doc.findAllElements('i');

    for (var item in items) {
      var key = item.getAttribute('s1');
      var value = item.getAttribute('s2');
      // 无需处理
      // var type = item.getAttribute('s3');

      if (key == null || value == null || value.isEmpty) {
        continue;
      }

      var intValue = int.tryParse(value) ?? 0;

      switch (key) {
        case 'attach_size_limit':
          rolePower.attachSizeLimit = intValue;
          break;
        case 'batch_person_limit':
          rolePower.batchPersonLimit = intValue;
          break;
        case 'board_ace':
          rolePower.boardAce = intValue;
          break;
        case 'msg_ace':
          rolePower.msgAce = intValue;
          break;
        case 'order_system':
          rolePower.orderSystem = intValue;
          break;
        case 'profile_edit':
          rolePower.profileEdit = intValue;
          break;
        case 'profile_view':
          rolePower.profileView = intValue;
          break;
      }
    }
  } catch (e) {
    // 解析出错时返回默认值
    return rolePower;
  }

  return rolePower;
}

List<Map<String, String>> parseOrgUserInfo(String xmlStr) {
  if (xmlStr.isEmpty) {
    return [];
  }

  try {
    final document = XmlDocument.parse(xmlStr);
    final userNodes = document.findAllElements('u');

    return userNodes.map((node) {
      Map<String, String> userInfo = {};

      // 处理属性(s1-s23)
      for (var attr in node.attributes) {
        userInfo[attr.name.local] = attr.value;
      }

      // 特殊处理s6子节点
      final s6Element = node.findElements('s6').firstOrNull;
      if (s6Element != null) {
        userInfo['s6'] = s6Element.innerText;
      }

      return userInfo;
    }).toList();
  } catch (e) {
    return [];
  }
}

List<Map<String, String>> parseAllUserStatus(String xml) {
  if (xml.isEmpty) {
    return [];
  }

  final xmlDoc = XmlDocument.parse(xml);
  final users = xmlDoc.findAllElements('u');

  return users.map((user) {
    return {
      's1': user.getAttribute('s1') ?? '',
      's2': user.getAttribute('s2') ?? '',
      's3': user.getAttribute('s3') ?? '',
    };
  }).toList();
}

class FriendListResult {
  final List<Map<String, String>> friend_group;
  final List<Map<String, String>> friend;

  FriendListResult({
    required this.friend_group,
    required this.friend,
  });
}

FriendListResult parseFriendListInfo(String xml) {
  if (xml.isEmpty) {
    return FriendListResult(friend_group: [], friend: []);
  }

  final doc = XmlDocument.parse(xml);
  final groups = <Map<String, String>>[];
  final friends = <Map<String, String>>[];

  // 解析所有 g 标签(好友组)
  for (var g in doc.findAllElements('g')) {
    var group = <String, String>{};
    for (var attr in g.attributes) {
      group[attr.name.local] = attr.value;
    }
    groups.add(group);
  }

  // 解析所有 u 标签(好友)
  for (var u in doc.findAllElements('u')) {
    var friend = <String, String>{
      // 确保 s5 字段存在,即使为空
      's5': '',
    };
    for (var attr in u.attributes) {
      friend[attr.name.local] = attr.value;
    }
    friends.add(friend);
  }

  return FriendListResult(
    friend_group: groups,
    friend: friends,
  );
}

/// 解析安全级别 XML
/// 示例 XML:
/// <l>
///   <a s1="1" s2="公开" s3="#a8a8a8"></a>
///   <a s1="2" s2="内部" s3="#5f5959"></a>
/// </l>
List<Map<String, String>> parseSecurityLevel(String xml) {
  if (xml.isEmpty) {
    return [];
  }

  final xmlDoc = XmlDocument.parse(xml);
  final result = <Map<String, String>>[];

  // 获取所有 a 标签
  final items = xmlDoc.findAllElements('a');

  for (var item in items) {
    final map = <String, String>{};

    // 获取属性 s1, s2, s3
    for (var attr in item.attributes) {
      map[attr.name.local] = attr.value;
    }

    result.add(map);
  }

  return result;
}

List<ServerMapInfo> parseServerMapInfo(String jsonStr) {
  if (jsonStr.isEmpty) return [];

  try {
    final List<dynamic> jsonList = json.decode(jsonStr);
    return jsonList.map((item) => ServerMapInfo.fromJson(item)).toList();
  } catch (e) {
    return [];
  }
}
