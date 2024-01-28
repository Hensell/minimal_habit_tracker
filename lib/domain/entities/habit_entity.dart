class HabitEntity {
  final int? id;
  final String title;
  final String description;
  final int lastDate;
  final int codePoint;
  final List<int> dates;

  HabitEntity(
      {required this.title,
      required this.description,
      required this.codePoint,
      this.id,
      lastDate,
      dates})
      : dates = dates ?? [],
        lastDate = lastDate ?? 0;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "codePoint": codePoint,
      "dates": dates,
    };
  }

  HabitEntity copyWith(
      {String? newTitle,
      String? newDescription,
      int? newCodePoint,
      List<int>? newDates}) {
    return HabitEntity(
      id: id,
      title: newTitle ?? title,
      description: newDescription ?? description,
      lastDate: lastDate,
      codePoint: newCodePoint ?? codePoint,
      dates: newDates ?? List<int>.from(dates),
    );
  }

  static HabitEntity fromMap(Map<String, dynamic> map, int id) {
    return HabitEntity(
      id: id,
      title: map["title"],
      description: map["description"],
      lastDate: map["lastDate"],
      codePoint: map["codePoint"],
      dates: List<int>.from(map["dates"]),
    );
  }
}
