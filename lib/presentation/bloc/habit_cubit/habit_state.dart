part of 'habit_cubit.dart';

@immutable
sealed class HabitState {}

final class HabitInitial extends HabitState {}

final class HabitSuccess extends HabitState {
  final List<HabitEntity> habits;
  HabitSuccess(this.habits);
}

final class HabitSuccessOne extends HabitState {
  final HabitEntity habits;
  HabitSuccessOne(this.habits);
}

final class HabitLoading extends HabitState {}

final class HabitError extends HabitState {}

final class HabitCommentSuccess extends HabitState {
  final List<CommentEntity>? rows;
  final Map<String, List<CommentEntity>>? maps;
  HabitCommentSuccess({this.rows, this.maps});
}

final class HabitOneCommentSuccess extends HabitState {
  final CommentEntity rows;
  HabitOneCommentSuccess(this.rows);
}
