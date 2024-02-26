import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minimal_habit_tracker/domain/entities/comment_entity.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/comment_repository.dart';
import 'package:minimal_habit_tracker/domain/repositories/habit_repository.dart';

import '../../../core/utils/date_utilities.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  final HabitRepository _habitRepository;
  final CommentRepository? _commentRepository;

  HabitCubit(this._habitRepository, {CommentRepository? commentRepository})
      : _commentRepository = commentRepository,
        super(HabitInitial());

  insertComment(String comment, int id) {
    Map<String, String> firstComment = {
      DateUtilities.getTodayFormated(): comment
    };

    CommentEntity entity = CommentEntity(idHabit: id, comment: firstComment);
    _commentRepository!.insert(entity);
  }

  Future<void> get() async {
    emit(HabitLoading());
    final list = await _habitRepository.get();
    emit(HabitSuccess(list));
  }

  Future<void> insert(HabitEntity habitEntity) async {
    final habits = await _habitRepository.insert(habitEntity);

    emit(HabitSuccess(habits));
  }

  Future<void> update(HabitEntity habitEntity, {bool emitValue = true}) async {
    final value = await _habitRepository.update(habitEntity);
    emit(HabitSuccessOne(value));
  }

  Future<void> toggle(int key) async {
    final updatedHabit = await _habitRepository.toggleAndReturnList(key);
    emit(HabitSuccess(updatedHabit));
  }

  Future<void> getOne(int key) async {
    emit(HabitLoading());
    final value = await _habitRepository.getOne(key);
    emit(HabitSuccessOne(value));
  }

  Future<void> toggleOne(int key) async {
    final updatedHabit = await _habitRepository.toggleAndReturnOne(key);
    emit(HabitSuccessOne(updatedHabit));
  }

  Future<int> delete(HabitEntity habitEntity) async {
    final key = await _habitRepository.delete(habitEntity);
    return key;
  }
}
