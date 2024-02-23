import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/data/repositories/comment_repository_impl.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HabitRepositoryImpl>(
          create: (_) => HabitRepositoryImpl(),
        ),
        RepositoryProvider<CommentRepositoryImpl>(
          create: (_) => CommentRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
