import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';

abstract class LocalDataSource {
  Future<List<HabitEntity>> get();
  insert(HabitEntity habitEntity);
}
