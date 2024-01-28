class GetToday {
  static int getToday() {
    DateTime currentDate = DateTime.now();
    DateTime dateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    return dateWithoutTime.millisecondsSinceEpoch;
  }
}
