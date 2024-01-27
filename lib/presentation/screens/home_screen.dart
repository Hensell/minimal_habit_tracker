import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HabitListScreen();
  }
}
