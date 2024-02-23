import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> get();
  Future<List<HabitEntity>> insert(HabitEntity habitEntity);
  Future<HabitEntity> update(HabitEntity habitEntity);
  Future<int> delete(HabitEntity habitEntity);
  Future<List<HabitEntity>> toggleAndReturnList(int key);
  Future<HabitEntity> getOne(int key);
  Future<HabitEntity> toggleAndReturnOne(int key);
}
