import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtilities {
  static int getToday() {
    DateTime currentDate = DateTime.now();
    DateTime dateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    return dateWithoutTime.millisecondsSinceEpoch;
  }

  static String getTodayFormated() {
    DateTime currentDate = DateTime.now();
    String dateFormated = DateFormat('dd/MM/yyyy').format(currentDate);

    return dateFormated;
  }

  static DateTime firstDayOfTheMonth() {
    DateTime now = DateTime.now();
    DateTime aYearAgo = DateTime(now.year, now.month, 1);
    return aYearAgo;
  }

  static String getFormatDate(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('MMMM', Localizations.localeOf(context).languageCode)
            .format(now);
    return formattedDate;
  }

  static int daysOfTheMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  static int differenceBetweenDates() {
    Duration difference = DateTime.now().difference(firstDayOfTheMonth());
    return difference.inDays;
  }

  static List<DateTime> millisecondsToDate(List<int> dates) {
    List<DateTime> dateTimes = dates.map((timestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }).toList();

    return dateTimes;
  }

  static List<int> dateToMilliseconds(List<DateTime> dates) {
    List<int> timestamps = dates.map((date) {
      return date.millisecondsSinceEpoch;
    }).toList();

    return timestamps;
  }
}
