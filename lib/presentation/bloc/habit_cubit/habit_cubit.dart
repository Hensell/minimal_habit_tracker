import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/habit_repository.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  final HabitRepository _habitRepository;

  HabitCubit(this._habitRepository) : super(HabitInitial());

  Future<void> get() async {
    emit(HabitLoading());
    final list = await _habitRepository.get();
    emit(HabitSuccess(list));
  }

  Future<void> insert(HabitEntity habitEntity) async {
    await _habitRepository.insert(habitEntity);
  }

  Future<void> update(HabitEntity habitEntity) async {
    final value = await _habitRepository.update(habitEntity);
    emit(HabitSuccessOne(value));
  }

  Future<void> toggle(int key) async {
    final updatedHabit = await _habitRepository.toggleToday(key);
    emit(HabitSuccess(updatedHabit));
  }

  Future<void> getOne(int key) async {
    emit(HabitLoading());
    final value = await _habitRepository.getOne(key);
    emit(HabitSuccessOne(value));
  }

  Future<void> toggleOne(int key) async {
    final updatedHabit = await _habitRepository.toggleTodayOne(key);
    emit(HabitSuccessOne(updatedHabit));
  }

  Future<int> delete(HabitEntity habitEntity) async {
    final key = await _habitRepository.delete(habitEntity);
    return key;
  }
}
