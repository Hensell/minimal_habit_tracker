import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:minimal_habit_tracker/presentation/bloc/habit_cubit/habit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/habit_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/common/textfields_column_widget.dart';

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

  CustomScaffold bodyMethod(BuildContext context) {
    return CustomScaffold(
      title: Text(AppLocalizations.of(context)!.addHabit),
      body: TextfieldsColumnWidget(
        nameController: _nameController,
        descriptionController: _descriptionController,
        selectedIcon: _selectedIcon,
      ),
      bottonBar: ElevatedButton.icon(
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
            _nameController.clear();
            _descriptionController.clear();
          },
          icon: const Icon(Icons.save),
          label: Text(AppLocalizations.of(context)!.saveHabit)),
    );
  }
}
