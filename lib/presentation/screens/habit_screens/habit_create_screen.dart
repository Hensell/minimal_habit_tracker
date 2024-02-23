import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:minimal_habit_tracker/presentation/bloc/habit_cubit/habit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_button.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';

import '../../../domain/entities/habit_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/common/textfields_column_widget.dart';

class HabitCreateScreen extends StatefulWidget {
  const HabitCreateScreen({super.key});

  @override
  State<HabitCreateScreen> createState() => _HabitCreateScreenState();
}

class _HabitCreateScreenState extends State<HabitCreateScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _colorController =
      TextEditingController(text: Colors.greenAccent.value.toString());
  final ValueNotifier<bool> _canComent = ValueNotifier(false);
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _colorController.dispose();
    _canComent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCubit(
          RepositoryProvider.of<HabitRepositoryImpl>(context, listen: false)),
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
        body: Column(
          children: [
            TextfieldsColumnWidget(
              nameController: _nameController,
              descriptionController: _descriptionController,
              canComent: _canComent,
              colorController: _colorController,
            ),
          ],
        ),
        bottonBar: CustomButton(
          onPressed: () {
            if (_nameController.text.isEmpty ||
                _descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: const Color(0xFF523f5f),
                  content: Text(
                    AppLocalizations.of(context)!.emptyNameOrDescription,
                    style: const TextStyle(color: Color(0xFF9ecaff)),
                  )));
              return;
            }

            context.read<HabitCubit>().insert(HabitEntity(
                title: _nameController.text,
                description: _descriptionController.text,
                color: int.parse(
                  _colorController.text,
                ),
                canComent: _canComent.value));

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: const Color(0xFF523f5f),
                content: Text(AppLocalizations.of(context)!.savedSuccessfully,
                    style: const TextStyle(color: Color(0xFF9ecaff)))));
            _nameController.clear();
            _descriptionController.clear();
          },
          color: const Color(0xFF523f5f),
          borderRadius: 0,
          width: double.infinity,
          text: Text(
            AppLocalizations.of(context)!.saveHabit,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
