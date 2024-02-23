import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  insert(CommentEntity entity);
  Future<List<CommentEntity>> get();
  Future<CommentEntity> update(CommentEntity entity);
  Future<int> delete(CommentEntity entity);
  Future<CommentEntity> getOne(int id);
}
