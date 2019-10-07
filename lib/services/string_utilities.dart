import 'package:intl/intl.dart';

String formatTimestamp(String dateString) {
  DateTime time = DateTime.parse(dateString);
  return DateFormat.yMMMd('en_US').add_jm().format(time).toString();
}