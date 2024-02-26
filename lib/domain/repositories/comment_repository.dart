import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  insert(CommentEntity entity);
  Future<List<CommentEntity>> get(int idHabit);
  Future<void> update(
      {required int id, required String newText, required String mapKey});
  Future<int> delete({required int id});
  Future<List<CommentEntity>> getOne(int id);
}
