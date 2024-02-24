import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';

import '../../../data/repositories/comment_repository_impl.dart';
import '../../../data/repositories/habit_repository_impl.dart';
import '../../bloc/habit_cubit/habit_cubit.dart';

class CommentListScreen extends StatelessWidget {
  const CommentListScreen({super.key, required this.habit});
  final HabitEntity habit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCubit(
          RepositoryProvider.of<HabitRepositoryImpl>(context, listen: false),
          commentRepository: RepositoryProvider.of<CommentRepositoryImpl>(
              context,
              listen: false))
        ..getOneComment(habit.id!),
      child: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitOneCommentSuccess) {
            return CustomScaffold(
                title: Text(habit.title),
                body: ListTile(
                  title: Text(
                      "Last comment: ${state.rows.lastComment.keys.first} : ${state.rows.lastComment.values.first}"),
                  subtitle: ListView.builder(
                    itemCount: state.rows.comments!.length,
                    itemBuilder: (context, index) {
                      String key = state.rows.comments!.keys.elementAt(index);
                      List<String> value = state.rows.comments![key]!;
                      return Column(
                        children: [
                          Text(key,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Column(
                            children: value.map((item) => Text(item)).toList(),
                          ),
                          const Divider(), // Otra opción para separar los elementos
                        ],
                      );
                    },
                  ),
                ),
                route: HabitDetailScreen(
                  habitEntity: habit,
                ));
          }
          //todo texto
          return const Text("Cargando");
        },
      ),
    );
  }
}
