import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';
import 'package:sembast/sembast.dart';

import '../database_provider.dart';

class CommentHandler implements CommentRepository {
  final store = intMapStoreFactory.store("comments");

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
        // Copiar la entidad existente
        CommentEntity newEntity = entity.copyWith();

        // Obtener la clave para los comentarios
        String keyComment = 'comments';

        // Obtener los comentarios existentes
        var comments = await existing.ref.get(txn);

        Map<String, dynamic>? commentsMap =
            comments?[keyComment] as Map<String, dynamic>?;

        // Agregar los comentarios al nuevoEntity
        commentsMap?.forEach((keys, values) {
          if (newEntity.comments!.containsKey(keys)) {
            newEntity.comments![keys]!.addAll(values);
          } else {
            newEntity.comments![keys] = values;
          }
        });

        // Actualizar la entidad existente con los nuevos comentarios
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
