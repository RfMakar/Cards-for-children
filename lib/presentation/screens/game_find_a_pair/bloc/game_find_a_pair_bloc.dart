import 'package:bloc/bloc.dart';
import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/core/objects/game_find_a_pair/game_find_a_pair.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'game_find_a_pair_event.dart';
part 'game_find_a_pair_state.dart';

class GameFindAPairBloc extends Bloc<GameFindAPairEvent, GameFindAPairState> {
  GameFindAPairBloc(this._babyCardRepository, this._audioPlayerService)
      : super(const GameFindAPairState()) {
    on<GameFindAPairInitialization>(_onInitialization);
    on<GameFindAPairOnTap>(_onTapGameCard);
    on<GameFindAPairRestartGame>(_onRestartGame);
  }
  final BabyCardRepository _babyCardRepository;
  final AudioPlayerService _audioPlayerService;

  void _onInitialization(
    GameFindAPairInitialization event,
    Emitter<GameFindAPairState> emit,
  ) async {
    emit(state.copyWith(status: GameFindAPairStatus.loading));
    try {
      final resBabyCards = await _babyCardRepository.getBabyCards(
        categoryId: event.categoryId,
      );
      if (resBabyCards.success) {
        emit(
          state.copyWith(
            status: GameFindAPairStatus.success,
            babyCards: resBabyCards.data,
            gameFindAPair: GameFindAPair(babyCards: resBabyCards.data!),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GameFindAPairStatus.failure,
            error: resBabyCards.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GameFindAPairStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void _onTapGameCard(
    GameFindAPairOnTap event,
    Emitter<GameFindAPairState> emit,
  ) async {
    final game = state.gameFindAPair!;

    game.onTapCard(event.gameFindAPairId);
    emit(state.copyWith(gameFindAPair: game));

    if (game.isCheckCard) {
      return;
    } else {
      if (game.examinationCards()) {
        emit(state.copyWith(gameFindAPair: game));
        _playTrue();

        if (game.restart) {
          emit(state.copyWith(status: GameFindAPairStatus.congratulation));
        }
      } else {
        emit(state.copyWith(gameFindAPair: game));
        _playFalse();
        await game.cardWrongToEnabled();
        emit(state.copyWith(gameFindAPair: game));
      }
    }
  }

  void _onRestartGame(
    GameFindAPairRestartGame event,
    Emitter<GameFindAPairState> emit,
  ) async {
    final game = state.gameFindAPair!;
    game.restartGame();
    emit(state.copyWith(
        status: GameFindAPairStatus.success, gameFindAPair: game));
  }

  Future<void> _playTrue() async {
    await _audioPlayerService.stop();
    _audioPlayerService.play(AppAssetsAudio.audioGameTrue);
  }

  Future<void> _playFalse() async {
    await _audioPlayerService.stop();
    _audioPlayerService.play(AppAssetsAudio.audioGameFalse);
  }

  @override
  Future<void> close() {
    _audioPlayerService.dispose();
    return super.close();
  }
}
