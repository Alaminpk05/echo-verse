//  import 'package:intl/intl.dart';

// String formatLastActive(int? lastActive) {
//     if (lastActive == null) return 'Unknown';

//     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastActive);
//     DateTime now = DateTime.now();

//     if (now.difference(dateTime).inDays == 0) {
//       return 'today at ${DateFormat('h:mm a').format(dateTime)}';
//     } else if (now.difference(dateTime).inDays == 1) {
//       return 'yesterday at ${DateFormat('h:mm a').format(dateTime)}';
//     } else {
//       return '${DateFormat('d MMM').format(dateTime)} at ${DateFormat('h:mm a').format(dateTime)}';
//     }
//   }

import 'package:intl/intl.dart';

String formateLastActive(String lastActive) {
  int timeStamp = int.parse(lastActive);
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timeStamp);

  return DateFormat('dd MMM hh:mm a').format(dateTime);
}
