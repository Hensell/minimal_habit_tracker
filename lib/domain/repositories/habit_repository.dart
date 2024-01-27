import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> get();
  insert(HabitEntity habitEntity);
}
