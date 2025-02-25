import 'package:flutter_test/flutter_test.dart';

import 'package:core/helpers/parse_xml.dart';

void main() {
  group('parse strings', () {
    test("parseUserInfoXml", () {
      var xml = '<u><i s1="BIRTHDAY"><![CDATA[1234368000000000]]></i><i s1="EMAIL"><![CDATA[2660@qq.com]]></i><i s1="JOB"><![CDATA[经理]]></i><i s1="MOBILE"><![CDATA[15726817101]]></i><i s1="NAME"><![CDATA[外网1]]></i><i s1="OPHONE"><![CDATA[262-2681532]]></i><i s1="ROOMNUM"><![CDATA[房间号值]]></i><i s1="SEX">2</i><i s1="SHORTNUM"><![CDATA[短号abc]]></i></u>';
      var kv = parseUserInfoXml(xml);
      expect(kv['BIRTHDAY'], equals("1234368000000000"));
      expect(kv['NAME'], equals("外网1"));
      expect(kv['EMAIL'], equals("2660@qq.com"));
      expect(kv['JOB'], equals("经理"));
      expect(kv['MOBILE'], equals("15726817101"));
      expect(kv['OPHONE'], equals("262-2681532"));
      expect(kv['SHORTNUM'], equals("短号abc"));
      expect(kv['ROOMNUM'], equals("房间号值"));
      expect(kv['SEX'], equals("2"));
    });

    test("parseAddinListXml", () {
      var xml =
          '''<l><a s1="board_12" s2="2" s3="" s4="公告" s5="[webserver]/Addin/board.html?ssid=[ssid]&amp;uid=[uid]&amp;uname=[uname]&amp;token=[token]" s6="1" s7="/Public/Addin/img/icon_board_s.png" s8="{&quot;width&quot;:&quot;1024&quot;,&quot;height&quot;:&quot;768&quot;}" s9="1" s10="board" s11="公告" s12="2" s13="1680599930000000" s14="board" s15="0" s16="" s17="0" s18="0" s19="/Public/Addin/img/icon_board_b.png" s20="1" s21="0"></a><a s1="flow_12" s2="2" s3="" s4="审批" s5="[webserver]/Addin/Flow/applyLists?start=0&amp;app_id=pc_client&amp;display_url=FlowPc%2FapplyLists&amp;ssid=[ssid]&amp;uid=[uid]&amp;uname=[uname]&amp;token=[token]" s6="1" s7="/Public/Addin/img/icon_approve_pc.png" s8="{&quot;width&quot;:&quot;950&quot;,&quot;height&quot;:&quot;600&quot;}" s9="0" s10="flow" s11="审批" s12="4" s13="1680599930000000" s14="custom" s15="0" s16="[webserver]/Addin/Flow/ajaxGetCheckCount%3Fuid=[uid]%26loginname=[loginname]%26uname=[uname]" s17="0" s18="2" s19="/Public/Addin/img/icon_flow_b.png" s20="1" s21="0"></a><a s1="pan_14" s2="4" s3="" s4="云盘" s5="[webserver]/Addin/pan.html?ssid=[ssid]&amp;uid=[uid]&amp;uname=[uname]&amp;token=[token]" s6="1" s7="/Public/Addin/img/icon_pan_s.png" s8="{&quot;width&quot;:&quot;1024&quot;,&quot;height&quot;:&quot;768&quot;}" s9="1" s10="pan" s11="云盘" s12="1" s13="1680599930000000" s14="pan" s15="0" s16="" s17="0" s18="0" s19="/Public/Addin/img/icon_pan_b.png" s20="1" s21="0"></a></l>''';
      var res = parseAddinListXml(xml);

      expect(res[0]['s1'], equals("board_12"));
      expect(res[0]['s2'], equals("2"));
      expect(res[0]['s3'], equals(""));
      expect(res[0]['s4'], equals("公告"));
      expect(res[0]['s5'], equals("[webserver]/Addin/board.html?ssid=[ssid]&uid=[uid]&uname=[uname]&token=[token]"));
      expect(res[0]['s6'], equals("1"));
      expect(res[0]['s7'], equals("/Public/Addin/img/icon_board_s.png"));
      expect(res[0]['s8'], equals("""{"width":"1024","height":"768"}"""));
      expect(res[0]['s9'], equals("1"));
      expect(res[0]['s10'], equals("board"));
      expect(res[0]['s11'], equals("公告"));
      expect(res[0]['s12'], equals("2"));
      expect(res[0]['s13'], equals("1680599930000000"));
      expect(res[0]['s14'], equals("board"));
      expect(res[0]['s15'], equals("0"));
      expect(res[0]['s16'], equals(""));
      expect(res[0]['s17'], equals("0"));
      expect(res[0]['s18'], equals("0"));
      expect(res[0]['s19'], equals("/Public/Addin/img/icon_board_b.png"));
      expect(res[0]['s20'], equals("1"));
      expect(res[0]['s21'], equals("0"));

      expect(res[1]['s1'], equals("flow_12"));
      expect(res[1]['s2'], equals("2"));
      expect(res[1]['s4'], equals("审批"));
      expect(res[1]['s5'], equals("[webserver]/Addin/Flow/applyLists?start=0&app_id=pc_client&display_url=FlowPc%2FapplyLists&ssid=[ssid]&uid=[uid]&uname=[uname]&token=[token]"));
      expect(res[1]['s7'], equals("/Public/Addin/img/icon_approve_pc.png"));
      expect(res[1]['s8'], equals("""{"width":"950","height":"600"}"""));
      expect(res[1]['s16'], equals("""[webserver]/Addin/Flow/ajaxGetCheckCount%3Fuid=[uid]%26loginname=[loginname]%26uname=[uname]"""));
      expect(res[1]['s19'], equals("/Public/Addin/img/icon_flow_b.png"));
      expect(res[1]['s21'], equals("0"));
    });

    test("parseGroupListXml", () {
      var xml =
          "<l><g s1='31C0AA1F-093C-47E4-890A-C990A0506D4E' s2='邵淮、外网2' n3='2' s4='102' s5='B3F2206C-CB5C-53DF-029E-49FA8B6C26ED' s6='外网2' s7='' n8='0' n9='0' n10='1000' n11='' n12='0' n13='0' s17='1682056648329402' n18='2' n19='0'><s14></s14><s15></s15><s16></s16><s17>1</s17><s18>0</s18><s19>0</s19><s20>0</s20></g><g s1='52A3BA28-4463-4554-BA53-7D9EDA52936E' s2='全体' n3='0' s4='105' s5='B3F2206C-CB5C-53DF-029E-49FA8B6C26ED' s6='邵淮' s7='' n8='0' n9='0' n10='1000' n11='' n12='0' n13='1' s17='1682499513255124' n18='7' n19='0'><s14></s14><s15></s15><s16></s16><s17>1</s17><s18>0</s18><s19>0</s19><s20>0</s20></g></l>";
      var res = parseGroupListXml(xml);
      // console.log(res);

      expect(res[0]['s1'], equals("31C0AA1F-093C-47E4-890A-C990A0506D4E"));
      expect(res[0]['s2'], equals("邵淮、外网2"));
      expect(res[0]['n3'], equals("2"));
      expect(res[0]['s4'], equals("102"));
      expect(res[0]['s5'], equals("B3F2206C-CB5C-53DF-029E-49FA8B6C26ED"));
      expect(res[0]['s6'], equals("外网2"));
      expect(res[0]['s7'], equals(""));
      expect(res[0]['n8'], equals("0"));
      expect(res[0]['n9'], equals("0"));
      expect(res[0]['n10'], equals("1000"));
      expect(res[0]['n11'], equals(""));
      expect(res[0]['n12'], equals("0"));
      expect(res[0]['n13'], equals("0"));
      expect(res[0]['s17'], equals("1682056648329402"));
      expect(res[0]['n18'], equals("2"));
      expect(res[0]['n19'], equals("0"));

      expect(res[0]['s14'], equals(""));
      expect(res[0]['s15'], equals(""));
      expect(res[0]['s16'], equals(""));
      expect(res[0]['s17_1'], equals("1"));
      expect(res[0]['s18'], equals("0"));
      expect(res[0]['s19'], equals("0"));
      expect(res[0]['s20'], equals("0"));

      expect(res[1]['s1'], equals("52A3BA28-4463-4554-BA53-7D9EDA52936E"));
    });

    test("parseGroupListXml empty", () {
      var xml = """<l></l>""";
      var res = parseGroupListXml(xml);
      expect(res.length, equals(0));
    });

    test("parseGroupMember", () {
      var xml = """<l><u s1='101' s2='B3F2206C-CB5C-53DF-029E-49FA8B6C26ED' s3='外网1' n4='0' n5='0' n6='0' /><u s1='102' s2='B3F2206C-CB5C-53DF-029E-49FA8B6C26ED' s3='外网2' n4='1' n5='0' n6='0' /></l>""";
      var res = parseGroupMember(xml);
      // console.log(res);

      expect(res[0]['s1'], equals("101"));
      expect(res[0]['s2'], equals("B3F2206C-CB5C-53DF-029E-49FA8B6C26ED"));
      expect(res[0]['s3'], equals('外网1'));
      expect(res[0]['n4'], equals('0'));
      expect(res[0]['n5'], equals('0'));
      expect(res[0]['n6'], equals('0'));
    });
    test("parseGroupMember empty", () {
      var xml = """<l></l>""";
      var res = parseGroupMember(xml);
      // console.log(res);
      expect(res.length, equals(0));
    });
  });

  // 组织用户信息
  group('org user info', () {
    test("user info empty", () {
      var testdata = "<l></l>";

      var res = parseOrgUserInfo(testdata);
      expect(res.length, equals(0));
    });

    test("user info", () {
      var testdata =
          """<l><u s1="101" s2="外网1" s3="ww1" s4="10000" s7="66666" s8="15726817105" s9="短号abc" s10="26608@qq.com" s11="经理23" s12="短号abc13" s13="ww1" s14="waiwang1" s15="1" s16="0" s17="1" s21="工号值" s22="所在机构abc" s23="直接上级aaa"><s6>12312</s6></u><u s1="102" s2="外网2" s3="ww2" s4="10000" s5="/data/B3F2206C-CB5C-53DF-029E-49FA8B6C26ED/upload/2023-07-17/1689613668802364b4fce900224.png" s7="153-465" s8="15726817104" s9="短号1" s10="26610@qq.com" s11="职位1" s12="房间号1" s13="ww2" s14="waiwang2" s15="1" s16="-28800000000" s17="1" s21="工号1" s22="所在机构1"><s6>1235567666666661111</s6></u><u s1="103" s2="外网3" s3="ww3" s4="10000" s13="ww3" s14="waiwang3" s16="315504000000000" s17="1"></u><u s1="104" s2="外网4" s3="ww4" s4="10000" s13="ww4" s14="waiwang4" s15="1" s16="315504000000000" s17="1"></u><u s1="105" s2="邵淮" s3="shaoh" s4="10000" s13="sh" s14="shaohuai" s15="1" s16="315504000000000" s17="1"></u><u s1="106" s2="孙磊" s3="sunl" s4="10000" s13="sl" s14="sunlei" s15="1" s16="315504000000000" s17="1"></u><u s1="107" s2="杨富强" s3="yangfq" s4="10000" s13="yfq" s14="yangfuqiang" s15="1" s16="315504000000000" s17="1"></u><u s1="108" s2="欧阳辉" s3="oyh" s4="10000" s13="oyh" s14="ouyanghui" s16="315504000000000" s17="1"></u><u s1="109" s2="王行" s3="wh" s4="10000" s13="wh" s14="wanghang" s16="315504000000000" s17="1"></u><u s1="112" s2="a" s3="a" s4="10000" s13="a" s14="a" s16="315504000000000" s17="1"></u></l>""";

      var res = parseOrgUserInfo(testdata);
      expect(res[0]['s1'], equals("101"));
      expect(res[0]['s2'], equals("外网1"));
      expect(res[0]['s3'], equals("ww1"));
      expect(res[0]['s4'], equals("10000"));
      expect(res[0]['s6'], equals("12312"));
      expect(res[0]['s7'], equals("66666"));
      expect(res[0]['s8'], equals("15726817105"));
      expect(res[0]['s9'], equals("短号abc"));
      expect(res[0]['s10'], equals("26608@qq.com"));
      expect(res[0]['s12'], equals("短号abc13"));
      expect(res[0]['s13'], equals("ww1"));
      expect(res[0]['s14'], equals("waiwang1"));
      expect(res[0]['s15'], equals("1"));
      expect(res[0]['s16'], equals("0"));
      expect(res[0]['s17'], equals("1"));
      expect(res[0]['s21'], equals("工号值"));
      expect(res[0]['s22'], equals("所在机构abc"));

      expect(res[1]['s1'], equals("102"));
      expect(res[1]['s2'], equals("外网2"));
      expect(res[1]['s5'], equals("/data/B3F2206C-CB5C-53DF-029E-49FA8B6C26ED/upload/2023-07-17/1689613668802364b4fce900224.png"));
      expect(res[1]['s6'], equals("1235567666666661111"));
      expect(res[1]['s22'], equals("所在机构1"));
    });
  });

  group('user status', () {
    test("user status", () {
      var testData = '<l><u s1="101" s2="1" s3="1"></u><u s1="102" s2="1" s3="4"></u></l>';
      var result = parseAllUserStatus(testData);

      expect(result[0]['s1'], equals("101"));
      expect(result[0]['s2'], equals("1"));
      expect(result[0]['s3'], equals("1"));

      expect(result[1]['s1'], equals("102"));
      expect(result[1]['s2'], equals("1"));
      expect(result[1]['s3'], equals("4"));
    });
  });

  group('user friend', () {
    test("user friend", () {
      var testData = '''<l>
<g s1="5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D" s2="hello" s3="1702955184602340"/>
<g s1="A4AA89C9-41CE-454F-96B5-35DEE04F10FC" s2="123" s3="1702955188681838"/>
<u s1="495" s2="赵昂然" s3="" s4="1702955174729185" />
<u s1="497" s2="赵波峻" s3="5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D" s4="1702955178982474" />
<u s1="498" s2="于起白" s3="" s4="1702955177095168" />
</l>''';
      var result = parseFriendListInfo(testData);
      // 好友组

      expect(result.friend_group[0]['s1'], equals("5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D"));
      expect(result.friend_group[0]['s2'], equals("hello"));
      expect(result.friend_group[0]['s3'], equals("1702955184602340"));

      expect(result.friend_group[1]['s1'], equals("A4AA89C9-41CE-454F-96B5-35DEE04F10FC"));
      expect(result.friend_group[1]['s2'], equals("123"));
      expect(result.friend_group[1]['s3'], equals("1702955188681838"));

      // 好友
      expect(result.friend[0]['s1'], equals("495"));
      expect(result.friend[0]['s2'], equals("赵昂然"));
      expect(result.friend[0]['s3'], equals(""));
      expect(result.friend[0]['s4'], equals("1702955174729185"));
      expect(result.friend[0]['s5'], equals(""));

      expect(result.friend[1]['s1'], equals("497"));
      expect(result.friend[1]['s2'], equals("赵波峻"));
      expect(result.friend[1]['s3'], equals("5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D"));
      expect(result.friend[1]['s4'], equals("1702955178982474"));
      expect(result.friend[1]['s5'], equals(""));

      expect(result.friend[2]['s1'], equals("498"));
      expect(result.friend[2]['s2'], equals("于起白"));
      expect(result.friend[2]['s3'], equals(""));
      expect(result.friend[2]['s4'], equals("1702955177095168"));
      expect(result.friend[2]['s5'], equals(""));
    });

    test("user friend all empty", () {
      var testData = '<l></l>';
      var result = parseFriendListInfo(testData);

      expect(result.friend_group.length, equals(0));
      expect(result.friend.length, equals(0));
    });

    test("user friend empty friend", () {
      var testData = '''<l>
<g s1="5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D" s2="hello" s3="1702955184602340"/>
</l>''';
      var result = parseFriendListInfo(testData);

      expect(result.friend_group.length, equals(1));
      expect(result.friend_group[0]['s1'], equals("5D075587-9F2D-41A1-B7B9-EEC39CB3FC1D"));
      expect(result.friend_group[0]['s2'], equals("hello"));
      expect(result.friend_group[0]['s3'], equals("1702955184602340"));

      expect(result.friend.length, equals(0));
    });
  });

  // 角色权限
  group('role test', () {
    test("empty test", () {
      var s1 = '';
      var rolePower = parseRoleXml(s1);
      expect(rolePower.attachSizeLimit, equals(0));
      expect(rolePower.batchPersonLimit, equals(0));
      expect(rolePower.boardAce, equals(0));
      expect(rolePower.msgAce, equals(0));
      expect(rolePower.orderSystem, equals(0));
      expect(rolePower.profileEdit, equals(0));
      expect(rolePower.profileView, equals(0));
    });

    test("empty1 test", () {
      var s1 = '<l></l>';
      var rolePower = parseRoleXml(s1);
      expect(rolePower.attachSizeLimit, equals(0));
      expect(rolePower.batchPersonLimit, equals(0));
      expect(rolePower.boardAce, equals(0));
      expect(rolePower.msgAce, equals(0));
      expect(rolePower.orderSystem, equals(0));
      expect(rolePower.profileEdit, equals(0));
      expect(rolePower.profileView, equals(0));
    });

    test("role test", () {
      var s1 = '''<l>
<f s1='CLIENT'>
    <i s1='attach_size_limit' s2='8192' s3='1'/>
    <i s1='batch_person_limit' s2='1000' s3='1'/>
    <i s1='board_ace' s2='4' s3='0'/>
    <i s1='msg_ace' s2='40' s3='0'/>
    <i s1='order_system' s2='4' s3='0'/>
    <i s1='profile_edit' s2='4' s3='0'/>
    <i s1='profile_view' s2='4' s3='0'/>
</f>
</l>''';
      var rolePower = parseRoleXml(s1);
      expect(rolePower.attachSizeLimit, equals(8192));
      expect(rolePower.batchPersonLimit, equals(1000));
      expect(rolePower.boardAce, equals(4));
      expect(rolePower.msgAce, equals(40));
      expect(rolePower.orderSystem, equals(4));
      expect(rolePower.profileEdit, equals(4));
      expect(rolePower.profileView, equals(4));
    });
  });

  group('security level test', () {
    test("parse security level", () {
      var xml = '''<l><a s1="1" s2="公开" s3="#a8a8a8"></a><a s1="2" s2="内部" s3="#5f5959"></a><a s1="3" s2="秘密" s3="#ffbc47"></a><a s1="4" s2="机密" s3="#ff8a3d"></a><a s1="5" s2="绝密" s3="#ff3b30"></a></l>''';
      var result = parseSecurityLevel(xml);

      expect(result.length, equals(5));

      expect(result[0]['s1'], equals("1"));
      expect(result[0]['s2'], equals("公开"));
      expect(result[0]['s3'], equals("#a8a8a8"));

      expect(result[1]['s1'], equals("2"));
      expect(result[1]['s2'], equals("内部"));
      expect(result[1]['s3'], equals("#5f5959"));

      expect(result[2]['s1'], equals("3"));
      expect(result[2]['s2'], equals("秘密"));
      expect(result[2]['s3'], equals("#ffbc47"));

      expect(result[3]['s1'], equals("4"));
      expect(result[3]['s2'], equals("机密"));
      expect(result[3]['s3'], equals("#ff8a3d"));

      expect(result[4]['s1'], equals("5"));
      expect(result[4]['s2'], equals("绝密"));
      expect(result[4]['s3'], equals("#ff3b30"));
    });

    test("parse security level empty", () {
      var xml = "<l></l>";
      var result = parseSecurityLevel(xml);
      expect(result.length, equals(0));
    });
  });

  group('server map info', () {
    test("parse server map info", () {
      var jsonStr =
          '''[{"server_type":"内网地址","login_server":"192.168.3.245","web_server":"http://192.168.3.245:8000","file_server":"192.168.3.245:7777","media_server":"http://106.14.10.129:81;http://106.14.10.129:81;2a0f0452e54ea8368e5b2c73bb209b08|http://106.14.10.129:82;e10adc3949ba59abbe56e057f20f883e"},{"server_type":"外网地址","login_server":"101.69.228.146","web_server":"http://101.69.228.146:8000","file_server":"101.69.228.146:7777","media_server":"http://106.14.10.129:81;http://106.14.10.129:81;2a0f0452e54ea8368e5b2c73bb209b08|http://106.14.10.129:82;e10adc3949ba59abbe56e057f20f883e"},{"server_type":"外网地址","login_server":"bg.jiuqitech.cn","web_server":"http://bg.jiuqitech.cn:8000","file_server":"bg.jiuqitech.cn:7777","media_server":"http://106.14.10.129:81;http://106.14.10.129:81;2a0f0452e54ea8368e5b2c73bb209b08|http://106.14.10.129:82;e10adc3949ba59abbe56e057f20f883e"}]''';

      var result = parseServerMapInfo(jsonStr);
      expect(result.length, equals(3));

      // 验证第一个服务器信息
      expect(result[0].serverType, equals("内网地址"));
      expect(result[0].loginServer, equals("192.168.3.245"));
      expect(result[0].webServer, equals("http://192.168.3.245:8000"));
      expect(result[0].fileServer, equals("192.168.3.245:7777"));
      expect(result[0].mediaServer, equals("http://106.14.10.129:81;http://106.14.10.129:81;2a0f0452e54ea8368e5b2c73bb209b08|http://106.14.10.129:82;e10adc3949ba59abbe56e057f20f883e"));

      // 验证第二个服务器信息
      expect(result[1].serverType, equals("外网地址"));
      expect(result[1].loginServer, equals("101.69.228.146"));
      expect(result[1].webServer, equals("http://101.69.228.146:8000"));
      expect(result[1].fileServer, equals("101.69.228.146:7777"));

      // 验证第三个服务器信息
      expect(result[2].serverType, equals("外网地址"));
      expect(result[2].loginServer, equals("bg.jiuqitech.cn"));
      expect(result[2].webServer, equals("http://bg.jiuqitech.cn:8000"));
      expect(result[2].fileServer, equals("bg.jiuqitech.cn:7777"));
    });

    test("parse server map info empty", () {
      var jsonStr = "[]";
      var result = parseServerMapInfo(jsonStr);
      expect(result.length, equals(0));
    });
  });
}
