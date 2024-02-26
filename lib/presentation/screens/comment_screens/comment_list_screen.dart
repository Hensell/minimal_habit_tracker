import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimal_habit_tracker/core/utils/dialog_utils.dart';
import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/presentation/bloc/comment_cubit/comment_cubit.dart';
import 'package:minimal_habit_tracker/presentation/screens/habit_screens/habit_detail_screen.dart';
import 'package:minimal_habit_tracker/presentation/widgets/common/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/repositories/comment_repository_impl.dart';

class CommentListScreen extends StatefulWidget {
  const CommentListScreen({super.key, required this.habit});
  final HabitEntity habit;

  @override
  State<CommentListScreen> createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  final TextEditingController _addCommentController = TextEditingController();

  @override
  void dispose() {
    _addCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit(
          RepositoryProvider.of<CommentRepositoryImpl>(context, listen: false))
        ..getOneComment(widget.habit.id!),
      child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccess) {
            final maps = state.maps!;

            return CustomScaffold(
                title: Text(widget.habit.title),
                body: state.rows!.isNotEmpty
                    ? ListView.builder(
                        itemCount: maps.length,
                        itemBuilder: (context, index) {
                          var keys = maps.keys.toList();
                          var key = keys[index];
                          var comments = maps[key]!;

                          return ExpansionTile(
                            title: Text(
                              key,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            children: comments.map((comment) {
                              return Dismissible(
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 10),
                                  color: Colors.blueAccent,
                                  child: Text(
                                    AppLocalizations.of(context)!.editComment,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 10),
                                  color: Colors.redAccent,
                                  child: Text(
                                    AppLocalizations.of(context)!.deleteComment,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    return await DialogUtils
                                        .deleteCommentDialog(
                                            context: context,
                                            onDelete: () {
                                              context
                                                  .read<CommentCubit>()
                                                  .delete(
                                                      id: comment.id!,
                                                      idHabit: comment.idHabit);
                                            });
                                  } else {
                                    _addCommentController.text =
                                        comment.comment[key];
                                    return await DialogUtils.edditCommentDialog(
                                        context: context,
                                        onAdd: () {
                                          context.read<CommentCubit>().update(
                                              id: comment.id!,
                                              idHabit: comment.idHabit,
                                              newText:
                                                  _addCommentController.text,
                                              mapKey: key);
                                        },
                                        addCommentController:
                                            _addCommentController);
                                  }
                                },
                                key: Key(comment.id.toString()),
                                child: ListTile(
                                  title: Text('${comment.comment[key]}'),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.noComments,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Gap(20),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HabitDetailScreen(
                                                  habitEntity: widget.habit)));
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.toReturn))
                          ],
                        ),
                      ),
                route: HabitDetailScreen(
                  habitEntity: widget.habit,
                ));
          }

          return Material(child: Text(AppLocalizations.of(context)!.loading));
        },
      ),
    );
  }
}
