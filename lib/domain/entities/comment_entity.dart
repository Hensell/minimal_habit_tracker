class CommentEntity {
  final int? id;
  final Map<String, String> lastComment;
  final Map<String, List<String>>? comments;

  CommentEntity({this.id, required this.lastComment, this.comments});

  Map<String, dynamic> toMap() {
    return {
      "lastComment": lastComment,
      "comments": comments,
    };
  }

  CommentEntity copyWith({
    int? newId,
    Map<String, String>? newLastComment,
    Map<String, List<String>>? newComments,
  }) {
    return CommentEntity(
      id: newId ?? id,
      lastComment: newLastComment ?? lastComment,
      comments: newComments ?? comments,
    );
  }

  static CommentEntity fromMap(Map<String, dynamic> map, int id) {
    return CommentEntity(
      id: id,
      lastComment: map["lastComment"],
      comments: map["comments"],
    );
  }
}
