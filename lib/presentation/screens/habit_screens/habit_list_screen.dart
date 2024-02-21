import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/date_utilities.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/common/custom_list_title.dart';
import '../../widgets/habit_list/box_complete.dart';
import '../../widgets/habit_list/habit_list_app_bar.dart';
import 'habit_create_screen.dart';
import 'habit_detail_screen.dart';

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
                                Colors.black38.withOpacity(0.5),
                                Colors.black38.withOpacity(1)
                              ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          CustomListTitle(
                            title: habit.title,
                            description: habit.description,
                            color: Color(habit.color),
                            icon: IconData(habit.codePoint,
                                fontFamily: "MaterialIcons"),
                            valueSwitch:
                                habit.lastDate == DateUtilities.getToday(),
                            onChangedSwitch: (value) {
                              context.read<HabitCubit>().toggle(habit.id!);
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
