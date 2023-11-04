import 'package:date_format/date_format.dart';

class GlobalFunctions {
  static DateTime stringToDate(String date) {
    List<String> parts = date.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2].substring(0, 4));
    DateTime newDate = DateTime(year, month, day);
    return newDate;
  }

  static String dateToString(DateTime date) {
    String newDate = formatDate(date, ['dd', '-', 'mm', '-', 'yyyy']);
    return newDate;
  }
}
