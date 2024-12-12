import 'package:bloc/bloc.dart';
import 'package:busycards/core/objects/game_show_me/game_show_me.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:meta/meta.dart';

part 'game_show_me_event.dart';
part 'game_show_me_state.dart';

class GameShowMeBloc extends Bloc<GameShowMeEvent, GameShowMeState> {
  GameShowMeBloc(
    this._gameRepository,
    this._audioPlayerService,
  ) : super(const GameShowMeState()) {
    on<GameShowMeInitialization>(_onInitialization);
    on<GameShowMeRestart>(_onRestartGame);
    on<GameShowMeOnTapCard>(_onTapCardGame);
  }
  final GameRepository _gameRepository;
  final AudioPlayerService _audioPlayerService;

  void _onInitialization(
    GameShowMeInitialization event,
    Emitter<GameShowMeState> emit,
  ) async {
    emit(state.copyWith(status: GameShowMeStatus.loading));
    try {
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

      final res =
          resQuestions.success && resAnswerNo.success && resAnswerYes.success;
      if (res) {
        final gameShowMe = GameShowMe(
          babyCards: event.babyCards,
          questionsGame: resQuestions.data!,
          answersGameYes: resAnswerYes.data!,
          answersGameNo: resAnswerNo.data!,
        );

        emit(state.copyWith(
          status: GameShowMeStatus.success,
          gameShowMe: gameShowMe,
        ));

        _audioPlayerService.playList(gameShowMe.playQuestion());
        await gameShowMe.installStatusCardsEnabled();

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

  void _onTapCardGame(
    GameShowMeOnTapCard event,
    Emitter<GameShowMeState> emit,
  ) async {
    final game = state.gameShowMe!;
    final gameShowMeCardId = event.gameShowMeCardId;
    final isCheck = game.isCheck(event.gameShowMeCardId);

    if (isCheck) {
      _audioPlayerService.play(game.playAnswerYes());

      game.installStatusRight(gameShowMeCardId);
      emit(state.copyWith(status: GameShowMeStatus.success));

      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(status: GameShowMeStatus.congratulation));
    } else {
      await _audioPlayerService.stop();
      _audioPlayerService.play(game.playAnswerNo());
      game.installStatusWrong(gameShowMeCardId);
      emit(state.copyWith(status: GameShowMeStatus.success));
    }
  }

  void _onRestartGame(
    GameShowMeRestart event,
    Emitter<GameShowMeState> emit,
  ) async {
    final game = state.gameShowMe!;
    game.initRestartGame();

    emit(state.copyWith(status: GameShowMeStatus.success));

    _audioPlayerService.playList(game.playQuestion());
    await game.installStatusCardsEnabled();

    emit(state.copyWith(status: GameShowMeStatus.success));
  }

  @override
  Future<void> close() {
    _audioPlayerService.dispose();
    return super.close();
  }
}
