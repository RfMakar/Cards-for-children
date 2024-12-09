import 'package:bloc/bloc.dart';
import 'package:busycards/core/objects/game_show_me/game_show_me.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:meta/meta.dart';

part 'game_show_me_event.dart';
part 'game_show_me_state.dart';

class GameShowMeBloc extends Bloc<GameShowMeEvent, GameShowMeState> {
  GameShowMeBloc(this._babyCardRepository, this._gameRepository)
      : super(const GameShowMeState()) {
    on<GameShowMeInitialization>(_onInitialization);
    on<GameShowMeRestart>(_onRestartGame);
  }
  final BabyCardRepository _babyCardRepository;
  final GameRepository _gameRepository;

  void _onInitialization(
    GameShowMeInitialization event,
    Emitter<GameShowMeState> emit,
  ) async {
    emit(state.copyWith(status: GameShowMeStatus.loading));
    try {
      final resBabyCards = await _babyCardRepository.getBabyCards(
        categoryId: event.categoryId,
      );

      final resQuestions = await _gameRepository.getQuestionsGame(
        gameId: event.gameId,
      );

      final resAnswerNo = await _gameRepository.getAnswersGame(
        gameId: event.gameId,
        result: 0,
      );
      final resAnswerYes = await _gameRepository.getAnswersGame(
        gameId: event.gameId,
        result: 1,
      );

      final res = resBabyCards.success &&
          resQuestions.success &&
          resAnswerNo.success &&
          resAnswerYes.success;
      if (res) {
        final gameShowMe = GameShowMe(
          babyCards: resBabyCards.data!,
          questionsGame: resQuestions.data!,
          answersGameYes: resAnswerYes.data!,
          answersGameNo: resAnswerNo.data!,
        );
        emit(state.copyWith(
          status: GameShowMeStatus.success,
          gameShowMe: gameShowMe,
        ));
      } else {
        emit(
          state.copyWith(
            status: GameShowMeStatus.failure,
            error: 'Данные не загрузились',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GameShowMeStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void _onRestartGame(
    GameShowMeRestart event,
    Emitter<GameShowMeState> emit,
  ) async {
    try {
     
      if (state.status == GameShowMeStatus.success) {
         emit(state.copyWith(status: GameShowMeStatus.loading));
        state.gameShowMe!.initRestartGame();
        emit(state.copyWith(
          status: GameShowMeStatus.success,
          gameShowMe: state.gameShowMe,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GameShowMeStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
