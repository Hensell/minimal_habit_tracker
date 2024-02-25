import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            final elementC = state.rows.comments;
            return CustomScaffold(
                title: Text(habit.title),
                body: ListView.builder(
                  itemCount: elementC!.length,
                  itemBuilder: (context, index) {
                    String key = elementC.keys.elementAt(index);
                    List<dynamic> value = elementC[key]!;
                    return Column(
                      children: [
                        Text(key,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children: value.map((item) => Text(item)).toList(),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
                route: HabitDetailScreen(
                  habitEntity: habit,
                ));
          }

          return Text(AppLocalizations.of(context)!.loading);
        },
      ),
    );
  }
}
