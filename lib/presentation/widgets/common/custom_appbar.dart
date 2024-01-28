import 'package:flutter/material.dart';

import '../../screens/habit_screens/habit_list_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          title: title,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HabitListScreen()),
                );
              },
              icon: const Icon(Icons.close)),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
