import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';

import '../database/database_client.dart';

class CommentRepositoryImpl implements CommentRepository {
  final DatabaseClient databaseClient = DatabaseClient();

  @override
  Future<int> delete({required int id}) async {
    final result = await databaseClient.commentHandler.delete(id: id);
    return result;
  }

  @override
  Future<List<CommentEntity>> get(int idHabit) async {
    final result = await databaseClient.commentHandler.get(idHabit);
    return result;
  }

  @override
  Future<List<CommentEntity>> getOne(int id) async {
    final result = await databaseClient.commentHandler.getOne(id);
    return result;
  }

  @override
  insert(CommentEntity entity) {
    databaseClient.commentHandler.insert(entity);
  }

  @override
  Future<void> update(
      {required int id, required String newText, required mapKey}) async {
    await databaseClient.commentHandler
        .update(id: id, newText: newText, mapKey: mapKey);
  }
}
