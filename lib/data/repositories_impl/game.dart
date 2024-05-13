import 'package:busycards/core/resources/data_state.dart';
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
  Future<DataState<List<AnswerGameModel>>> getAnswersGame({
    required int gameId,
    required int result,
  }) async {
    try {
      final dataMap = await _sqfliteClientApp.getAnswersGame(
        gameId: gameId,
        result: result,
      );
      final List<AnswerGameModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => AnswerGameModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<QuestionGameModel>>> getQuestionsGame({
    required int gameId,
  }) async {
    try {
      final dataMap = await _sqfliteClientApp.getQuestionsGame(
        gameId: gameId,
      );
      final List<QuestionGameModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => QuestionGameModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
