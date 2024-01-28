import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/functions/date_utilities.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';
import '../../widgets/common/custom_appbar.dart';

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
            const Center(
              child: Text('Cargando'),
            );
          } else if (state is HabitSuccessOne) {
            return bodyMethod(context, state);
          }

          return const Material(child: Text('Error'));
        },
      ),
    );
  }

  Scaffold bodyMethod(BuildContext context, HabitSuccessOne state) {
    final habit = state.habits;

    final ValueNotifier<IconData> selectedIcon =
        ValueNotifier<IconData>(Icons.home);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
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
              leading:
                  Icon(IconData(habit.codePoint, fontFamily: "MaterialIcons")),
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
                        newDates:
                            DateUtilities.dateToMilliseconds(nonNullableDates));

                    context.read<HabitCubit>().update(newHabit);
                  },
                ))
          ],
        ),
      )),
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
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Editar información',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      filled: true, label: Text('Nombre')),
                ),
                const Gap(20),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      filled: true, label: Text('Descripción')),
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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'El nombre o la descripción estan vacios.')));
                        return;
                      }

                      HabitEntity newHabit = habit.copyWith(
                          newTitle: nameController.text,
                          newDescription: descriptionController.text,
                          newCodePoint: selectedIcon.value.codePoint);
                      context.read<HabitCubit>().update(newHabit);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('¡Guardado con exito!')));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Actualizar')),
              ],
            ),
            value: 'panel1')
      ],
    );
  }
}
