import 'package:flutter/material.dart';

import '../../screens/habit_screens/habit_list_screen.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key, required this.title, required this.body, this.bottonBar});
  final Widget title;
  final Widget body;
  final Widget? bottonBar;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HabitListScreen()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: title,
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
        body: body,
        bottomNavigationBar: bottonBar,
      ),
    );
  }
}
