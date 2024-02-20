class HabitEntity {
  final int? id;
  final String title;
  final String description;
  final int lastDate;
  final int codePoint;
  final List<int> dates;
  final int color;

  HabitEntity(
      {required this.title,
      required this.description,
      required this.codePoint,
      this.id,
      lastDate,
      dates,
      color})
      : dates = dates ?? [],
        lastDate = lastDate ?? 0,
        color = color ?? 4285132974;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "codePoint": codePoint,
      "dates": dates,
      "color": color
    };
  }

  HabitEntity copyWith(
      {String? newTitle,
      String? newDescription,
      int? newLastDate,
      int? newCodePoint,
      List<int>? newDates,
      int? newColor}) {
    return HabitEntity(
        id: id,
        title: newTitle ?? title,
        description: newDescription ?? description,
        lastDate: newLastDate ?? lastDate,
        codePoint: newCodePoint ?? codePoint,
        dates: newDates ?? List<int>.from(dates),
        color: newColor ?? color);
  }

  static HabitEntity fromMap(Map<String, dynamic> map, int id) {
    return HabitEntity(
        id: id,
        title: map["title"],
        description: map["description"],
        lastDate: map["lastDate"],
        codePoint: map["codePoint"],
        dates: List<int>.from(map["dates"]),
        color: map["color"]);
  }
}
