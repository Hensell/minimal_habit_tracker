class DateUtilities {
  static int getToday() {
    DateTime currentDate = DateTime.now();
    DateTime dateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    return dateWithoutTime.millisecondsSinceEpoch;
  }

  static DateTime firstDayOfTheYear() {
    DateTime now = DateTime.now();
    DateTime aYearAgo = DateTime(now.year, 1, 1);
    return aYearAgo;
  }

  static int differenceBetweenDates() {
    Duration difference = DateTime.now().difference(firstDayOfTheYear());
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
