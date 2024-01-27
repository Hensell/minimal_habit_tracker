import 'package:flutter/material.dart';

import 'habit_list_screen.dart';

class HabitUpdateScreen extends StatelessWidget {
  const HabitUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HabitListScreen()),
              );
            },
            icon: const Icon(Icons.close)),
      ),
    );
  }
}
