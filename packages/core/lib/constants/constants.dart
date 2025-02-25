import '../exceptions/exceptions.dart';

part 'cmd.dart';
part 'error_codes.dart';
part 'enum.dart';
part 'propo_key.dart';
part 'login_response_key.dart';

const int maxMsgType = 14;
const int maxDbMsgSubjectLength = 48; // 存入数据库subject字段的最大长度
const int maxCollectMsgNum = 100; // MAX_COLLECT_MSGNUM 最大收藏消息熟料
