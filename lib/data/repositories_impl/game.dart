import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/model/answer_game.dart';
import 'package:busycards/data/model/qustion_game.dart';
import 'package:busycards/domain/repositories/game.dart';

class GameRepositoryImpl implements GameRepository {
  final SqfliteClientApp _sqfliteClientApp;

  GameRepositoryImpl({
    required SqfliteClientApp sqfliteClientApp,
  }) : _sqfliteClientApp = sqfliteClientApp;
  @override
  Future<List<AnswerGameModel>> getAnswersGame({
    required int gameId,
    required int result,
  }) async {
    final data = await _sqfliteClientApp.getAnswersGame(
      gameId: gameId,
      result: result,
    );
    return data.isNotEmpty
        ? data.map((e) => AnswerGameModel.fromMap(e)).toList()
        : [];
  }

  @override
  Future<List<QuestionGameModel>> getQuestionsGame({
    required int gameId,
  }) async {
    final data = await _sqfliteClientApp.getQuestionsGame(
      gameId: gameId,
    );
    return data.isNotEmpty
        ? data.map((e) => QuestionGameModel.fromMap(e)).toList()
        : [];
  }
}
