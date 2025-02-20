enum PropKeyType {
  msgId("msgid"),
  cmdId("cmdid"),
  attachments("attachments"),
  contentLength("content-length"),
  contentType("content-type"),
  content("content"),
  extData("extdata"),
  isLocalGroup("islocalgroup"),
  msgFlag("msgflag"),
  subject("subject"),
  filterErr("filtererr"),
  ack("ack"),
  ackParam("ackparam"),
  body("body"),
  dataPath("datapath"),
  chater("chater"),
  msgExtType("msgexttype"),
  senderId("senderid"),
  senderName("sendername"),
  msgType("msgtype"),
  opType("optype"),
  sendDate("senddate"),
  dataZip("datazip"),
  notice("notice"),
  receiveUsers("receive-users"),
  fGuid("fguid"),
  desc("desc"),
  viace("viace"),
  pic("pic"),
  note("note"),
  tag("tag"),
  vistace("vistace"),
  ssids("ssids"),
  userCount("usercount"),
  ssid1UserInfos("ssid1_userinfos"),
  groupId("group_id"),
  statusDesc("statusdesc"),
  groupId2("groupid"),
  newGroupId("newgroupid"),
  oldGroupId("oldgroupid"),
  groupName("groupname"),
  platform("platform"),
  type("type"),
  flag("flag"),
  owId("owid"),
  owName("owname"),
  owSsid("owssid"),
  status("status"),
  users("users"),
  groupMuteId("groupmuteid"),
  isGroupMute("isgroupmute"),
  muteIds("muteids"),
  muteType("mutetype"),
  userId("_userid_"),
  isBurn("is_burn"),
  chatId("chatid"),
  revokeTime("revoketime"),
  domain("domain"),
  method("method"),
  revokeUser("revokeuser"),
  isAdmin("isadmin"),
  data("data"),
  newPwd("newpwd"),
  oldPwd("oldpwd"),

  // pc 端
  macAddr("macaddr"), // 电脑的mac地址

  // 移动端
  ipushId("ipushid"), // 阿里的推送id,(目前只有苹果在用)
  iVendorId("ivendor_id"), // android 厂商id
  iVendorType("ivendor_type"), // android 厂商类型
  userDevice("userdevice"), // 用户设备

  isMock("is_mock"); // 本地模拟的通知添加mock 通知

  final String value;
  const PropKeyType(this.value);
}
