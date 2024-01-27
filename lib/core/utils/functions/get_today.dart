class GetToday {
  static String getToday() {
    DateTime fechaActual = DateTime.now();

    int day = fechaActual.day;
    int month = fechaActual.month;
    int year = fechaActual.year;

    String today = "$day/$month/$year";

    return today;
  }
}
