import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minimal_habit_tracker/core/utils/date_utilities.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_create_screen.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/habit_list/box_complete.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HabitCubit(Provider.of<HabitRepositoryImpl>(context, listen: false))
            ..get(),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            return CircularProgressIndicator(
              semanticsLabel: AppLocalizations.of(context)!.loading,
            );
          } else if (state is HabitSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Minimal habit tracker'),
                centerTitle: true,
              ),
              body: CustomScrollView(slivers: [
                SliverList.builder(
                    itemCount: state.habits.length,
                    itemBuilder: (context, index) {
                      final habit = state.habits[index];

                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(
                            bottom: 15, left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(habit.title),
                              subtitle: Text(habit.description),
                              leading: Icon(
                                IconData(habit.codePoint,
                                    fontFamily: "MaterialIcons"),
                                color: Color(habit.color),
                              ),
                              trailing: Switch(
                                  activeColor: Color(habit.color),
                                  value: habit.lastDate ==
                                      DateUtilities.getToday(),
                                  onChanged: (value) {
                                    context
                                        .read<HabitCubit>()
                                        .toggle(habit.id!);
                                  }),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            HabitDetailScreen(
                                              habitEntity: habit,
                                            ))));
                              },
                            ),
                            ExpansionPanelList.radio(
                              initialOpenPanelValue: "panel",
                              children: [
                                ExpansionPanelRadio(
                                  canTapOnHeader: true,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        AppLocalizations.of(context)!.toggle,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                  body: SizedBox(
                                    height: 150,
                                    child: BoxComplete(
                                      dates: habit.dates,
                                      color: habit.color,
                                    ),
                                  ),
                                  value: 'panel',
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ]),
              floatingActionButton: FloatingActionButton(
                  tooltip: AppLocalizations.of(context)!.addHabit,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HabitCreateScreen()),
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
