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
    Object today = value!['lastDate'] ?? 0;

    var map = cloneMap(value);
    map['lastDate'] = today == GetToday.getToday() ? 0 : GetToday.getToday();

    if (!(map['dates'] as List<dynamic>).contains(GetToday.getToday())) {
      (map['dates'] as List<dynamic>).add(GetToday.getToday());
    } else {
      (map['dates'] as List<dynamic>).removeLast();
    }

    await store.record(key).update(db, map);

    return await get();
  }
}
