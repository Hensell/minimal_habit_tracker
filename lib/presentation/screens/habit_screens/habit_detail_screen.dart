import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_update_screen.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_button.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_list_title.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';

import '../../../core/utils/date_utilities.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import 'habit_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

DateTime finalDate = DateTime.now();

class HabitDetailScreen extends StatefulWidget {
  const HabitDetailScreen({super.key, required this.habitEntity});
  final HabitEntity habitEntity;

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  DateTime finalDate = DateTime.now();
  final ValueNotifier<IconData> selectedIcon =
      ValueNotifier<IconData>(Icons.home);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  void dispose() {
    selectedIcon.dispose();
    nameController.dispose();
    descriptionController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCubit(
          RepositoryProvider.of<HabitRepositoryImpl>(context, listen: false))
        ..getOne(widget.habitEntity.id!),
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

  bodyMethod(BuildContext context, HabitSuccessOne state) {
    final habit = state.habits;

    return CustomScaffold(
      colorAppBar: Color(habit.color),
      iconAppBar: Icon(
        Icons.close,
        color: Color(habit.color).computeLuminance() > 0.5
            ? Colors.black
            : Colors.white,
      ),
      title: Text(
        AppLocalizations.of(context)!.modify,
        style: TextStyle(
            color: Color(habit.color).computeLuminance() > 0.5
                ? Colors.black
                : Colors.white),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CustomListTitle(
                elipsis: false,
                title: habit.title,
                description: habit.description,
                colorSwitch: Color(habit.color),
                valueSwitch: habit.lastDate == DateUtilities.getToday(),
                onChangedSwitch: (value) {
                  context.read<HabitCubit>().toggleOne(habit.id!);
                }),
            showCalendarMethod(context, habit),
          ],
        ),
      )),
      bottonBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              width: MediaQuery.of(context).size.width / 2,
              borderRadius: 0,
              onPressed: () {
                DialogUtils.deleteDialog(
                    context: context,
                    onDelete: () async {
                      await context
                          .read<HabitCubit>()
                          .delete(habit)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: const Color(0xFF523f5f),
                            content: Text(
                                AppLocalizations.of(context)!.habitDeleted,
                                style: const TextStyle(
                                    color: Color(0xFF9ecaff)))));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HabitListScreen()),
                        );
                      });
                    });
              },
              color: Colors.redAccent,
              text: Text(
                AppLocalizations.of(context)!.deleteHabit,
                style: const TextStyle(color: Colors.white),
              )),
          CustomButton(
              borderRadius: 0,
              width: MediaQuery.of(context).size.width / 2,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => HabitUpdateScreen(
                              habit: habit,
                            ))));
              },
              color: Colors.deepPurpleAccent,
              text: Text(AppLocalizations.of(context)!.modify,
                  style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  ExpansionPanelList showCalendarMethod(
      BuildContext context, HabitEntity habit) {
    return ExpansionPanelList.radio(
      children: [
        ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const Gap(10),
                      Text(
                        AppLocalizations.of(context)!.showCalendar,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ));
            },
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CalendarDatePicker2(
                  displayedMonthDate: finalDate,
                  config: CalendarDatePicker2Config(
                      lastDate: DateTime.now(),
                      calendarType: CalendarDatePicker2Type.multi),
                  value: DateUtilities.millisecondsToDate(habit.dates),
                  onDisplayedMonthChanged: (value) {
                    finalDate = value;
                  },
                  onValueChanged: (dates) {
                    List<DateTime> nonNullableDates =
                        dates.whereType<DateTime>().toList();

                    bool existsToday = nonNullableDates.any((date) =>
                        date.year == DateTime.now().year &&
                        date.month == DateTime.now().month &&
                        date.day == DateTime.now().day);
                    HabitEntity newHabit;
                    if (existsToday) {
                      newHabit = habit.copyWith(
                          newLastDate: DateUtilities.getToday(),
                          newDates: DateUtilities.dateToMilliseconds(
                              nonNullableDates));
                    } else {
                      newHabit = habit.copyWith(
                          newLastDate: 0,
                          newDates: DateUtilities.dateToMilliseconds(
                              nonNullableDates));
                    }

                    context.read<HabitCubit>().update(newHabit);
                  },
                )),
            value: 'panel1')
      ],
    );
  }
}
