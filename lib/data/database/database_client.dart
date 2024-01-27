import 'package:minimal_habit_tracker/core/utils/functions/get_today.dart';
import 'package:minimal_habit_tracker/data/database/database_provider.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

class DatabaseClient {
  final store = intMapStoreFactory.store("habit");

  Future<void> insertHabit(HabitEntity habitEntity) async {
    final db = await DatabaseProvider.database;
    await store.add(db, habitEntity.toMap());
  }

  Future<List<HabitEntity>> get() async {
    final db = await DatabaseProvider.database;

    final snapshot = await store.find(db);

    return snapshot.map((item) {
      final pwd = HabitEntity.fromMap(item.value, item.key);
      return pwd;
    }).toList();
  }

  Future<List<HabitEntity>> toogle(int key) async {
    final db = await DatabaseProvider.database;
    var value = await store.record(key).get(db);
    Object today = value!['lastDate'] ?? "";

    var map = cloneMap(value);
    map['lastDate'] = today == GetToday.getToday() ? '' : GetToday.getToday();

    if (!(map['dates'] as Map<String, dynamic>)
        .cast<String, bool>()
        .containsKey(GetToday.getToday())) {
      (map['dates'] as Map<String, dynamic>)
          .cast<String, bool>()[GetToday.getToday()] = true;
    } else {
      (map['dates'] as Map<String, dynamic>)
          .cast<String, bool>()
          .remove(GetToday.getToday());
    }

    await store.record(key).update(db, map);

    return await get();
  }
}
