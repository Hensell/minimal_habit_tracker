class HabitEntity {
  final int? id;
  final String title;
  final String description;
  final int lastDate;
  final List<int> dates;
  final int color;
  final bool canComent;

  HabitEntity(
      {required this.title,
      required this.description,
      this.id,
      lastDate,
      dates,
      color,
      canComent})
      : dates = dates ?? [],
        lastDate = lastDate ?? 0,
        color = color ?? 4285132974,
        canComent = canComent ?? false;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "dates": dates,
      "color": color,
      "canComent": canComent
    };
  }

  HabitEntity copyWith(
      {String? newTitle,
      String? newDescription,
      int? newLastDate,
      int? newCodePoint,
      List<int>? newDates,
      int? newColor,
      bool? newCanComent}) {
    return HabitEntity(
        id: id,
        title: newTitle ?? title,
        description: newDescription ?? description,
        lastDate: newLastDate ?? lastDate,
        dates: newDates ?? List<int>.from(dates),
        color: newColor ?? color,
        canComent: newCanComent ?? canComent);
  }

  static HabitEntity fromMap(Map<String, dynamic> map, int id) {
    return HabitEntity(
        id: id,
        title: map["title"],
        description: map["description"],
        lastDate: map["lastDate"],
        dates: List<int>.from(map["dates"]),
        color: map["color"],
        canComent: map["canComent"]);
  }
}
