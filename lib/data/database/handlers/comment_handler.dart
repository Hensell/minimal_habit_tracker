import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';
import 'package:sembast/sembast.dart';

import '../database_provider.dart';

class CommentHandler implements CommentRepository {
  final store = intMapStoreFactory.store("comments");

  @override
  Future<List<CommentEntity>> get(int idHabit) async {
    final db = await DatabaseProvider.database;
    Finder finder = Finder(filter: Filter.equals("idHabit", idHabit));
    final snapshot = await store.find(db, finder: finder);

    return snapshot.map((item) {
      final pwd = CommentEntity.fromMap(item.value, item.key);
      return pwd;
    }).toList();
  }

  @override
  insert(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    await db.transaction((txn) async {
      await store.add(txn, entity.toMap());
    });
  }

  @override
  Future<List<CommentEntity>> update(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    await store.record(entity.id!).update(db, entity.toMap());

    return await getOne(entity.id!);
  }

  @override
  Future<List<CommentEntity>> getOne(int id) async {
    final db = await DatabaseProvider.database;
    Finder finder = Finder(filter: Filter.equals("idHabit", id));

    final snapshot = await store.find(db, finder: finder);

    return snapshot.map((item) {
      final pwd = CommentEntity.fromMap(item.value, item.key);
      return pwd;
    }).toList();
  }

  @override
  Future<int> delete(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    final key = await store.record(entity.id!).delete(db);

    return key ?? 0;
  }
}
