import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/core/utils/color_utils.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle(
      {super.key,
      required this.title,
      required this.description,
      required this.color,
      required this.icon,
      required this.valueSwitch,
      required this.onChangedSwitch,
      this.onTap});
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final bool valueSwitch;
  final Function(bool) onChangedSwitch;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ColorUtils.adjustLightness(color), color])),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      trailing: Switch(
        activeColor: color,
        value: valueSwitch,
        onChanged: onChangedSwitch,
      ),
      onTap: onTap,
    );
  }
}
