import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/date_utilities.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/common/custom_appbar.dart';
import 'habit_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitEntity});
  final HabitEntity habitEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HabitCubit(Provider.of<HabitRepositoryImpl>(context, listen: false))
            ..getOne(habitEntity.id!),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            return CircularProgressIndicator(
              semanticsLabel: AppLocalizations.of(context)!.loading,
            );
          } else if (state is HabitSuccessOne) {
            return bodyMethod(context, state);
          }

          return CircularProgressIndicator(
            semanticsLabel: AppLocalizations.of(context)!.loading,
          );
        },
      ),
    );
  }

  PopScope bodyMethod(BuildContext context, HabitSuccessOne state) {
    final habit = state.habits;

    final ValueNotifier<IconData> selectedIcon =
        ValueNotifier<IconData>(Icons.home);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HabitListScreen()),
        );
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${habit.title} '),
              Icon(IconData(habit.codePoint, fontFamily: "MaterialIcons")),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              editMethod(nameController, descriptionController, selectedIcon,
                  habit, context),
              ListTile(
                title: Text(habit.title),
                subtitle: Text(habit.description),
                leading: Icon(
                    IconData(habit.codePoint, fontFamily: "MaterialIcons")),
                trailing: IconButton.filledTonal(
                  onPressed: () {
                    context.read<HabitCubit>().toggleOne(habit.id!);
                  },
                  icon: Icon(habit.lastDate == DateUtilities.getToday()
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.multi),
                    value: DateUtilities.millisecondsToDate(habit.dates),
                    onValueChanged: (dates) {
                      List<DateTime> nonNullableDates =
                          dates.whereType<DateTime>().toList();

                      HabitEntity newHabit = habit.copyWith(
                          newDates: DateUtilities.dateToMilliseconds(
                              nonNullableDates));

                      context.read<HabitCubit>().update(newHabit);
                    },
                  ))
            ],
          ),
        )),
      ),
    );
  }

  ExpansionPanelList editMethod(
      TextEditingController nameController,
      TextEditingController descriptionController,
      ValueNotifier<IconData> selectedIcon,
      HabitEntity habit,
      BuildContext context) {
    return ExpansionPanelList.radio(
      children: [
        ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton.filled(
                        highlightColor: Colors.redAccent,
                        onPressed: () => DialogUtils.deleteDialog(
                            context: context,
                            onDelete: () async {
                              await context
                                  .read<HabitCubit>()
                                  .delete(habit)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .habitDeleted)));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HabitListScreen()),
                                );
                              });
                            }),
                        icon: const Icon(Icons.delete)),
                    const Gap(10),
                    const CircleAvatar(
                      child: Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
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
                      label:
                          Text(AppLocalizations.of(context)!.habitDescription)),
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
                          )
                        ],
                        onChanged: (IconData? newValue) {
                          selectedIcon.value = newValue!;
                        },
                      );
                    }),
                ElevatedButton.icon(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .emptyNameOrDescription)));
                        return;
                      }

                      HabitEntity newHabit = habit.copyWith(
                          newTitle: nameController.text,
                          newDescription: descriptionController.text,
                          newCodePoint: selectedIcon.value.codePoint);
                      context.read<HabitCubit>().update(newHabit);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .savedSuccessfully)));
                    },
                    icon: const Icon(Icons.edit),
                    label: Text(AppLocalizations.of(context)!.saveChanges)),
              ],
            ),
            value: 'panel1')
      ],
    );
  }
}
