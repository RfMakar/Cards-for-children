import 'package:busycards/core/resources/data_state.dart';
import 'package:busycards/domain/entities/answer_game.dart';
import 'package:busycards/domain/entities/question_game.dart';

abstract class GameRepository {
  Future<DataState<List<AnswerGame>>> getAnswersGame({
    required int gameId,
    required int result,
  });
  Future<DataState<List<QuestionGame>>> getQuestionsGame({
    required int gameId,
  });
}
