class HabitEntity {
  final int? id;
  final String title;
  final String description;
  final String lastDate;
  final int codePoint;
  final Map<String, bool> dates;

  HabitEntity(
      {required this.title,
      required this.description,
      required this.codePoint,
      this.id,
      lastDate,
      Map<String, bool>? dates})
      : dates = dates ?? {},
        lastDate = lastDate ?? '';

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "lastDate": lastDate,
      "codePoint": codePoint,
      "dates": dates,
    };
  }

  static HabitEntity fromMap(Map<String, dynamic> map, int id) {
    return HabitEntity(
      id: id,
      title: map["title"],
      description: map["description"],
      lastDate: map["lastDate"],
      codePoint: map["codePoint"],
      dates: (map["dates"] as Map<String, dynamic>).cast<String, bool>(),
    );
  }
}
