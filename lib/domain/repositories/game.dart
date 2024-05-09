import 'package:busycards/domain/entities/answer_game.dart';
import 'package:busycards/domain/entities/question_game.dart';

abstract class GameRepository {
  Future<List<AnswerGame>> getAnswersGame({
    required int gameId,
    required int result,
  });
  Future<List<QuestionGame>> getQuestionsGame({
    required int gameId,
  });
}
