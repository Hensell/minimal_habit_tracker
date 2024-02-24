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
    final lastCommentMap = (map["lastComment"] as Map<String, dynamic>)
        .map<String, String>((key, value) => MapEntry(key, value.toString()));

    final commentsMap =
        (map["comments"] as Map<String, dynamic>?)?.map<String, List<String>>(
      (key, value) => MapEntry(key, List<String>.from(value as List<dynamic>)),
    );

    return CommentEntity(
      id: id,
      lastComment: lastCommentMap,
      comments: commentsMap,
    );
  }
}
