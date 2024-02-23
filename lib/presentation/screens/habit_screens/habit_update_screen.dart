import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/textfields_column_widget.dart';

class HabitUpdateScreen extends StatefulWidget {
  const HabitUpdateScreen({super.key, required this.habit});
  final HabitEntity habit;

  @override
  State<HabitUpdateScreen> createState() => _HabitUpdateScreenState();
}

class _HabitUpdateScreenState extends State<HabitUpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  late TextEditingController _colorController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habit.title);
    _descriptionController =
        TextEditingController(text: widget.habit.description);

    _colorController =
        TextEditingController(text: widget.habit.color.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCubit(
          RepositoryProvider.of<HabitRepositoryImpl>(context, listen: false)),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HabitDetailScreen(habitEntity: widget.habit)),
              );
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(_nameController.text),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HabitDetailScreen(habitEntity: widget.habit)),
                      );
                    },
                    icon: const Icon(Icons.close)),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextfieldsColumnWidget(
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      colorController: _colorController,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomButton(
                  onPressed: () => onSaveButtonPressed(widget.habit, context),
                  color: const Color(0xFF523f5f),
                  borderRadius: 0,
                  width: double.infinity,
                  text: Text(AppLocalizations.of(context)!.saveChanges)),
            ),
          );
        },
      ),
    );
  }

  void onSaveButtonPressed(HabitEntity habit, BuildContext context) {
    if (areFieldsEmpty()) {
      showSnackBar(
          messeage: AppLocalizations.of(context)!.emptyNameOrDescription);
      return;
    }

    context.read<HabitCubit>().update(createNewHabitFromFields(habit)).then(
          (value) => showSnackBar(
              messeage: AppLocalizations.of(context)!.savedSuccessfully),
        );
  }

  bool areFieldsEmpty() {
    return _nameController.text.isEmpty || _descriptionController.text.isEmpty;
  }

  void showSnackBar({required String messeage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF523f5f),
        content:
            Text(messeage, style: const TextStyle(color: Color(0xFF9ecaff))),
      ),
    );
  }

  HabitEntity createNewHabitFromFields(HabitEntity habit) {
    HabitEntity newHabit = habit.copyWith(
        newTitle: _nameController.text,
        newDescription: _descriptionController.text,
        newColor: int.parse(_colorController.text));

    return newHabit;
  }
}
