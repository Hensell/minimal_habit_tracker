import 'package:flutter/material.dart';

class HabitListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HabitListAppBar({super.key, required this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        toolbarHeight: 70,
        title: title,
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
