import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';
import 'package:sembast/sembast.dart';

import '../database_provider.dart';

class CommentHandler implements CommentRepository {
  final store = intMapStoreFactory.store("cooments");

  @override
  Future<List<CommentEntity>> get() async {
    final db = await DatabaseProvider.database;

    final snapshot = await store.find(db);

    return snapshot.map((item) {
      final pwd = CommentEntity.fromMap(item.value, item.key);
      return pwd;
    }).toList();
  }

  @override
  insert(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    await db.transaction((txn) async {
      var existing = await store
          .query(finder: Finder(filter: Filter.byKey(entity.id!)))
          .getSnapshot(txn);
      if (existing == null) {
        await store.record(entity.id!).add(txn, entity.toMap());
      } else {
        CommentEntity newEntity = entity.copyWith();

        String key = newEntity.lastComment.keys.first;
        String value = 'comments';

        var comments = await existing.ref.get(txn);
        Map<String, dynamic>? commentsMap =
            comments![value] as Map<String, dynamic>?;
        Object? commentsObject = commentsMap![key];
        List<String> subclave =
            List<String>.from(commentsObject as List<dynamic>);

        newEntity.comments!.putIfAbsent(key, () => subclave).addAll(subclave);

        await existing.ref.update(txn, newEntity.toMap());
      }
    });
  }

  @override
  Future<CommentEntity> update(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    await store.record(entity.id!).update(db, entity.toMap());

    return await getOne(entity.id!);
  }

  @override
  Future<CommentEntity> getOne(int id) async {
    final db = await DatabaseProvider.database;

    var value = await store.record(id).get(db);
    return CommentEntity.fromMap(value!, id);
  }

  @override
  Future<int> delete(CommentEntity entity) async {
    final db = await DatabaseProvider.database;

    final key = await store.record(entity.id!).delete(db);

    return key ?? 0;
  }
}
