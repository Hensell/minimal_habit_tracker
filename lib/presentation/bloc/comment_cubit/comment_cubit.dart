import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/comment_entity.dart';
import '../../../domain/repositories/comment_repository.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepository _commentRepository;
  CommentCubit(this._commentRepository) : super(CommentInitial());

  Future<void> getOneComment(int id) async {
    emit(CommentLoading());
    final result = await _commentRepository.getOne(id);

    Map<String, List<CommentEntity>> groupedComments = {};
    for (var comment in result) {
      var key = comment.comment.keys.first;
      if (groupedComments.containsKey(key)) {
        groupedComments[key]!.add(comment);
      } else {
        groupedComments[key] = [comment];
      }
    }

    emit(CommentSuccess(maps: groupedComments, rows: result));
  }

  Future<int> delete({required int id, required int idHabit}) async {
    final key = await _commentRepository.delete(id: id);
    getOneComment(idHabit);
    return key;
  }

  Future<void> update(
      {required int id,
      required int idHabit,
      required String newText,
      required String mapKey}) async {
    await _commentRepository.update(id: id, newText: newText, mapKey: mapKey);
    getOneComment(idHabit);
  }
}
