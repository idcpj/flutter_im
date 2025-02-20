export 'cmd.dart';
export 'error_codes.dart';
export 'enum.dart';
export 'propo_key.dart';
export 'login_response_key.dart';

const projectName = "FIMPro";
const projectReceiveFiles = "$projectName/My Received Files";
const projectData = "$projectName/Data";
const projectLog = "$projectName/Log";
const projectDumpCrashes = "$projectName/DumpCrashes";
const projectExpression = "$projectName/Expression";

const int maxMsgType = 14;
const int maxDbMsgSubjectLength = 48; // 存入数据库subject字段的最大长度
const int maxCollectMsgNum = 100; // MAX_COLLECT_MSGNUM 最大收藏消息熟料
