import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextfieldsColumnWidget extends StatelessWidget {
  const TextfieldsColumnWidget(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.selectedIcon,
      required this.colorController});
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController colorController;
  final ValueNotifier<IconData> selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
              filled: true,
              label: Text(AppLocalizations.of(context)!.habitName)),
        ),
        const Gap(20),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
              filled: true,
              label: Text(AppLocalizations.of(context)!.habitDescription)),
        ),
        const Gap(20),
        ValueListenableBuilder<IconData>(
            valueListenable: selectedIcon,
            builder: (context, value, _) {
              return DropdownButton<IconData>(
                isExpanded: true,
                value: value,
                items: const [
                  DropdownMenuItem(
                    value: Icons.home,
                    child: Icon(Icons.home),
                  ),
                  DropdownMenuItem(
                    value: Icons.favorite,
                    child: Icon(Icons.favorite),
                  ),
                  DropdownMenuItem(
                    value: Icons.star,
                    child: Icon(Icons.star),
                  ),
                  DropdownMenuItem(
                    value: Icons.shopping_cart,
                    child: Icon(Icons.shopping_cart),
                  ),
                ],
                onChanged: (IconData? newValue) {
                  selectedIcon.value = newValue!;
                },
              );
            }),
        ColorPicker(
          onColorChanged: (Color value) {
            colorController.text = value.value.toString();
          },
          pickerTypeLabels: <ColorPickerType, String>{
            ColorPickerType.primary: AppLocalizations.of(context)!.primary,
            ColorPickerType.accent: AppLocalizations.of(context)!.accent,
          },
          color: Color(colorController.text.isEmpty
              ? Colors.greenAccent.value
              : int.parse(colorController.text)),
        ),
      ],
    );
  }
}
