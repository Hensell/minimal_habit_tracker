import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minimal_habit_tracker/core/utils/dialog_utils.dart';
import 'package:minimal_habit_tracker/data/repositories/comment_repository_impl.dart';
import '../../../core/utils/date_utilities.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/common/custom_list_title.dart';
import '../../widgets/habit_list/box_complete.dart';
import '../../widgets/habit_list/habit_list_app_bar.dart';
import 'habit_create_screen.dart';
import 'habit_detail_screen.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  TextEditingController addCommentController = TextEditingController();

  @override
  void dispose() {
    addCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCubit(
          RepositoryProvider.of<HabitRepositoryImpl>(context, listen: false),
          commentRepository: RepositoryProvider.of<CommentRepositoryImpl>(
              context,
              listen: false))
        ..get(),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            return CircularProgressIndicator(
              semanticsLabel: AppLocalizations.of(context)!.loading,
            );
          } else if (state is HabitSuccess) {
            return Scaffold(
              appBar: HabitListAppBar(
                  title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Minimal habit tracker'),
                  Text(
                    DateUtilities.getFormatDate(context).capitalize,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )),
              body: ListView.builder(
                  itemCount: state.habits.length,
                  itemBuilder: (context, index) {
                    final habit = state.habits[index];

                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black38.withOpacity(0.7),
                                Colors.black38.withOpacity(0.9)
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Color(habit.color).withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(0, 0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          CustomListTitle(
                            title: habit.title,
                            description: habit.description,
                            colorSwitch: Color(habit.color),
                            valueSwitch:
                                habit.lastDate == DateUtilities.getToday(),
                            onChangedSwitch: (value) {
                              context.read<HabitCubit>().toggle(habit.id!);
                              if (habit.canComent && value) {
                                DialogUtils.addCommentDialog(
                                    context: context,
                                    onAdd: () {
                                      context.read<HabitCubit>().insertComment(
                                          addCommentController.text, habit.id!);
                                    },
                                    addCommentController: addCommentController);
                              }
                            },
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HabitDetailScreen(
                                            habitEntity: habit,
                                          ))));
                            },
                          ),
                          BoxComplete(
                            dates: habit.dates,
                            color: habit.color,
                          )
                        ],
                      ),
                    );
                  }),
              floatingActionButton: FloatingActionButton(
                  tooltip: AppLocalizations.of(context)!.addHabit,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HabitCreateScreen()),
                    );
                  },
                  child: const Icon(Icons.add)),
            );
          }
          return Center(
            child: Text(AppLocalizations.of(context)!.loading),
          );
        },
      ),
    );
  }
}
