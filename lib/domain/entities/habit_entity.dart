class HabitEntity {
  final String title;
  final String description;
  final String lastDate;
  final int codePoint;
  final List<String> dates;

  HabitEntity(
      {required this.title,
      required this.description,
      lastDate,
      required this.codePoint,
      List<String>? dates})
      : dates = dates ?? [''],
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

  static HabitEntity fromMap(Map<String, dynamic> map) {
    return HabitEntity(
      title: map["title"],
      description: map["description"],
      lastDate: map["lastDate"],
      codePoint: map["codePoint"],
      dates: List<String>.from(map["dates"]),
    );
  }
}
