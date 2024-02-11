import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minimal_habit_tracker/core/utils/date_utilities.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_create_screen.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import 'package:minimal_habit_tracker/presentation/widgets/habit_list/habit_list_app_bar.dart';
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
              body: CustomScrollView(slivers: [
                SliverList.builder(
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
                                  Colors.black38.withOpacity(0.5),
                                  Colors.black38.withOpacity(1)
                                ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(habit.title),
                              subtitle: Text(habit.description),
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(habit.color).withOpacity(0.8),
                                ),
                                child: Icon(
                                  IconData(habit.codePoint,
                                      fontFamily: "MaterialIcons"),
                                  color: Colors.white.withOpacity(1),
                                ),
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
                            SizedBox(
                              height: 200,
                              child: BoxComplete(
                                dates: habit.dates,
                                color: habit.color,
                              ),
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
