import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/presentation/bloc/habit_cubit/habit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/custom_appbar.dart';

class HabitCreateScreen extends StatelessWidget {
  HabitCreateScreen({super.key});

  final ValueNotifier<IconData> _selectedIcon =
      ValueNotifier<IconData>(Icons.home);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HabitCubit(Provider.of<HabitRepositoryImpl>(context, listen: false)),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          return bodyMethod(context);
        },
      ),
    );
  }

  Scaffold bodyMethod(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: Text('Crear habito'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration:
                const InputDecoration(filled: true, label: Text('Nombre')),
          ),
          const Gap(20),
          TextFormField(
            controller: _descriptionController,
            decoration:
                const InputDecoration(filled: true, label: Text('Descripción')),
          ),
          const Gap(20),
          ValueListenableBuilder<IconData>(
              valueListenable: _selectedIcon,
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
                    _selectedIcon.value = newValue!;
                  },
                );
              }),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            if (_nameController.text.isEmpty ||
                _descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('El nombre o la descripción estan vacios.')));
              return;
            }

            context.read<HabitCubit>().insert(HabitEntity(
                title: _nameController.text,
                description: _descriptionController.text,
                codePoint: _selectedIcon.value.codePoint));

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Guardado con exito!')));
          },
          icon: const Icon(Icons.save),
          label: const Text('Guardar')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
