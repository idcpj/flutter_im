import 'package:intl/intl.dart';

/// 将DateTime格式化为指定格式的字符串
/// [dateTime] 需要格式化的DateTime对象
/// [pattern] 格式化模式，默认为 'yyyy-MM-dd HH:mm:ss'
/// 返回格式化后的字符串
String timeFormat(DateTime dateTime, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(dateTime);
}
