import 'package:intl/intl.dart';

String formateLastActive(String lastActive) {
  int timeStamp = int.parse(lastActive);
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timeStamp);

  return DateFormat('dd MMM hh:mm a').format(dateTime);
}
