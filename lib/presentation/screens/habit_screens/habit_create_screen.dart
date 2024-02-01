import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:minimal_habit_tracker/presentation/bloc/habit_cubit/habit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/habit_entity.dart';
import 'habit_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitCreateScreen extends StatelessWidget {
  HabitCreateScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<IconData> _selectedIcon = ValueNotifier(Icons.star);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HabitCubit(Provider.of<HabitRepositoryImpl>(context, listen: false)),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          return bodyMethod(context);
        },
      ),
    );
  }

  PopScope bodyMethod(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HabitListScreen()),
        );
      },
      child: Scaffold(
        appBar:
            CustomAppbar(title: Text(AppLocalizations.of(context)!.addHabit)),
        body: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  filled: true,
                  label: Text(AppLocalizations.of(context)!.habitName)),
            ),
            const Gap(20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  filled: true,
                  label: Text(AppLocalizations.of(context)!.habitDescription)),
            ),
            const Gap(20),
            ValueListenableBuilder<IconData>(
                valueListenable: _selectedIcon,
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
                      )
                    ],
                    onChanged: (IconData? newValue) {
                      _selectedIcon.value = newValue!;
                    },
                  );
                }),
          ],
        ),
        bottomNavigationBar: ElevatedButton.icon(
            onPressed: () {
              if (_nameController.text.isEmpty ||
                  _descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        AppLocalizations.of(context)!.emptyNameOrDescription)));
                return;
              }

              context.read<HabitCubit>().insert(HabitEntity(
                  title: _nameController.text,
                  description: _descriptionController.text,
                  codePoint: _selectedIcon.value.codePoint));

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.savedSuccessfully)));
            },
            icon: const Icon(Icons.save),
            label: Text(AppLocalizations.of(context)!.saveHabit)),
      ),
    );
  }
}
