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
  insert(HabitEntity habitEntity) {
    databaseClient.insertHabit(habitEntity);
  }

  @override
  Future<List<HabitEntity>> toggleToday(int complete) async {
    return await databaseClient.toogle(complete);
  }
}
