class CommentEntity {
  final int? id;
  final int idHabit;
  final Map<String, dynamic> comment;

  CommentEntity({this.id, required this.idHabit, required this.comment});

  Map<String, dynamic> toMap() {
    return {"idHabit": idHabit, "comment": comment};
  }

  CommentEntity copyWith(
      {int? newId, int? newIdHabit, Map<String, dynamic>? newComment}) {
    return CommentEntity(
        id: newId ?? id,
        idHabit: newIdHabit ?? idHabit,
        comment: newComment ?? comment);
  }

  static CommentEntity fromMap(Map<String, dynamic> map, int id) {
    final comment = (map["comment"] as Map<String, dynamic>)
        .map<String, String>((key, value) => MapEntry(key, value.toString()));
    final idHabit = (map["idHabit"] as int);

    return CommentEntity(id: id, idHabit: idHabit, comment: comment);
  }
}
