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
}
