 import 'package:intl/intl.dart';

String formatLastActive(int? lastActive) {
    if (lastActive == null) return 'Unknown';

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastActive);
    DateTime now = DateTime.now();

    if (now.difference(dateTime).inDays == 0) {
      return 'today at ${DateFormat('h:mm a').format(dateTime)}';
    } else if (now.difference(dateTime).inDays == 1) {
      return 'yesterday at ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return '${DateFormat('d MMM').format(dateTime)} at ${DateFormat('h:mm a').format(dateTime)}';
    }
  }