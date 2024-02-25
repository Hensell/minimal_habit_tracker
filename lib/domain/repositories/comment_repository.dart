import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  insert(CommentEntity entity);
  Future<List<CommentEntity>> get(int idHabit);
  Future<List<CommentEntity>> update(CommentEntity entity);
  Future<int> delete(CommentEntity entity);
  Future<List<CommentEntity>> getOne(int id);
}
