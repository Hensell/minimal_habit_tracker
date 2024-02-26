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
  Future<void> update(
      {required int id,
      required String newText,
      required String mapKey}) async {
    const String key = "comment";
    final db = await DatabaseProvider.database;
    var record = store.record(id);
    await record.update(db, {'$key.$mapKey': newText});
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
  Future<int> delete({required int id}) async {
    final db = await DatabaseProvider.database;

    final key = await store.record(id).delete(db);

    return key ?? 0;
  }
}
