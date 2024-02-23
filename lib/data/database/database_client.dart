import 'package:minimal_habit_tracker/core/utils/date_utilities.dart';
import 'package:minimal_habit_tracker/data/database/database_provider.dart';

import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import 'handlers/comment_handler.dart';

class DatabaseClient {
  final CommentHandler commentHandler = CommentHandler();

  final store = intMapStoreFactory.store("habit");

  Future<List<HabitEntity>> insertHabit(HabitEntity habitEntity) async {
    final db = await DatabaseProvider.database;
    await store.add(db, habitEntity.toMap());

    return await get();
  }

  Future<List<HabitEntity>> get() async {
    final db = await DatabaseProvider.database;

    final snapshot = await store.find(db);

    return snapshot.map((item) {
      final pwd = HabitEntity.fromMap(item.value, item.key);
      return pwd;
    }).toList();
  }

  Future<HabitEntity> getOne(int key) async {
    final db = await DatabaseProvider.database;

    var value = await store.record(key).get(db);
    return HabitEntity.fromMap(value!, key);
  }

  Future<List<HabitEntity>> toogle(int key) async {
    final db = await DatabaseProvider.database;
    var value = await store.record(key).get(db);

    var map = cloneMap(value!);

    bool lastDayIsToday =
        (map['dates'] as List<dynamic>).contains(DateUtilities.getToday());

    if (lastDayIsToday) {
      (map['dates'] as List<dynamic>).removeLast();
      map['lastDate'] = 0;
    } else {
      (map['dates'] as List<dynamic>).add(DateUtilities.getToday());
      map['lastDate'] = DateUtilities.getToday();
    }

    await store.record(key).update(db, map);

    return await get();
  }

  Future<HabitEntity> update(HabitEntity habit) async {
    final db = await DatabaseProvider.database;

    await store.record(habit.id!).update(db, habit.toMap());

    return await getOne(habit.id!);
  }

  Future<int> delete(HabitEntity habit) async {
    final db = await DatabaseProvider.database;

    final key = await store.record(habit.id!).delete(db);

    return key ?? 0;
  }

  Future<HabitEntity> toogleOne(int key) async {
    final db = await DatabaseProvider.database;
    var value = await store.record(key).get(db);
    Object today = value!['lastDate'] ?? 0;

    var map = cloneMap(value);
    map['lastDate'] =
        today == DateUtilities.getToday() ? 0 : DateUtilities.getToday();

    if (!(map['dates'] as List<dynamic>).contains(DateUtilities.getToday())) {
      (map['dates'] as List<dynamic>).add(DateUtilities.getToday());
    } else {
      (map['dates'] as List<dynamic>).removeLast();
    }

    await store.record(key).update(db, map);

    return await getOne(key);
  }
}
