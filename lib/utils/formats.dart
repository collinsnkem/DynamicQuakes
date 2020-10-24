//! FIRST OF ALL, YOU NEED TO IMPORT THE "INTL" PACKAGE

import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime dateTime) {
    return DateFormat("EEE, MMM d, ''yy, h:mm a").format(dateTime);
  }
}
