part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentSuccess extends CommentState {
  final List<CommentEntity>? rows;
  final Map<String, List<CommentEntity>>? maps;
  CommentSuccess({this.rows, this.maps});
}
