import 'package:intl/intl.dart';

class DataAndTimeUtil {
  static String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the date as "22 Jun 24, 4:25pm"
    final formatter = DateFormat("dd MMM yy, h:mma", 'en_US');
    return formatter.format(date).toLowerCase();
  }
}
