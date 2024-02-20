import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:provider/provider.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HabitRepositoryImpl>(
          create: (_) => HabitRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
