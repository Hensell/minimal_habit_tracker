import 'package:flutter/material.dart';

import '../../screens/habit_screens/habit_list_screen.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.bottonBar,
      this.colorAppBar,
      this.iconAppBar});
  final Widget title;
  final Widget body;
  final Widget? bottonBar;
  final Color? colorAppBar;
  final Widget? iconAppBar;
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
          backgroundColor: colorAppBar,
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
              icon: iconAppBar ?? const Icon(Icons.close)),
        ),
        body: body,
        bottomNavigationBar: bottonBar,
      ),
    );
  }
}
