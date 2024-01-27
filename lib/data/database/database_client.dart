import 'package:minimal_habit_tracker/data/database/database_provider.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:sembast/sembast.dart';

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
      final pwd = HabitEntity.fromMap(item.value);
      return pwd;
    }).toList();
  }
}
