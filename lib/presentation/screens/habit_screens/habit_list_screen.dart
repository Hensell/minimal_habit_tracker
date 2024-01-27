import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minimal_habit_tracker/core/utils/functions/get_today.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_update_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import 'habit_create_screen.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal habit tracker'),
        centerTitle: true,
      ),
      body: bodyMethod(),
      floatingActionButton: FloatingActionButton(
          tooltip: AppLocalizations.of(context)!.addHabit,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => HabitCreateScreen())));
          },
          child: const Icon(Icons.add)),
    );
  }

  BlocProvider<HabitCubit> bodyMethod() {
    return BlocProvider(
      create: (context) =>
          HabitCubit(Provider.of<HabitRepositoryImpl>(context, listen: false))
            ..get(),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            const Center(
              child: Text('Cargando'),
            );
          } else if (state is HabitSuccess) {
            return CustomScrollView(slivers: [
              SliverList.builder(
                  itemCount: state.habits.length,
                  itemBuilder: (context, index) {
                    final habit = state.habits[index];
                    return Card(
                        child: ListTile(
                      title: Text(habit.title),
                      subtitle: Text(habit.description),
                      leading: Icon(IconData(habit.codePoint,
                          fontFamily: "MaterialIcons")),
                      trailing: IconButton.filledTonal(
                        onPressed: () {
                          context.read<HabitCubit>().toggle(habit.id!);
                        },
                        icon: Icon(habit.lastDate == GetToday.getToday()
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const HabitUpdateScreen())));
                      },
                    ));
                  })
            ]);
          }

          return const Text('Error');
        },
      ),
    );
  }
}
