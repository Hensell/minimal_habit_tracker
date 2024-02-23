import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';

import '../database/database_client.dart';

class CommentRepositoryImpl implements CommentRepository {
  final DatabaseClient databaseClient = DatabaseClient();

  @override
  Future<int> delete(CommentEntity entity) async {
    final result = await databaseClient.commentHandler.delete(entity);
    return result;
  }

  @override
  Future<List<CommentEntity>> get() async {
    final result = await databaseClient.commentHandler.get();
    return result;
  }

  @override
  Future<CommentEntity> getOne(int id) async {
    final result = await databaseClient.commentHandler.getOne(id);
    return result;
  }

  @override
  insert(CommentEntity entity) {
    databaseClient.commentHandler.insert(entity);
  }

  @override
  Future<CommentEntity> update(CommentEntity entity) {
    final result = databaseClient.commentHandler.update(entity);
    return result;
  }
}
