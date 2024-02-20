import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/habit_repository.dart';

import '../database/database_client.dart';

class HabitRepositoryImpl implements HabitRepository {
  final DatabaseClient databaseClient = DatabaseClient();

  @override
  Future<List<HabitEntity>> get() async {
    return await databaseClient.get();
  }

  @override
  Future<List<HabitEntity>> insert(HabitEntity habitEntity) async {
    return await databaseClient.insertHabit(habitEntity);
  }

  @override
  Future<List<HabitEntity>> toggleToday(int complete) async {
    return await databaseClient.toogle(complete);
  }

  @override
  Future<HabitEntity> getOne(int key) async {
    return await databaseClient.getOne(key);
  }

  @override
  Future<HabitEntity> toggleTodayOne(int key) async {
    return await databaseClient.toogleOne(key);
  }

  @override
  Future<HabitEntity> update(HabitEntity habitEntity) async {
    return await databaseClient.update(habitEntity);
  }

  @override
  Future<int> delete(HabitEntity habitEntity) async {
    return await databaseClient.delete(habitEntity);
  }
}
