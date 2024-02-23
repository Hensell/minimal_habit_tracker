import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle(
      {super.key,
      required this.title,
      required this.description,
      required this.colorSwitch,
      required this.valueSwitch,
      required this.onChangedSwitch,
      this.onTap,
      this.elipsis = true});
  final String title;
  final String description;
  final Color colorSwitch;

  final bool valueSwitch;
  final Function(bool) onChangedSwitch;
  final VoidCallback? onTap;
  final bool elipsis;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        overflow: elipsis ? TextOverflow.ellipsis : TextOverflow.visible,
      ),
      trailing: Switch(
        activeColor: colorSwitch,
        value: valueSwitch,
        onChanged: onChangedSwitch,
      ),
      onTap: onTap,
    );
  }
}
