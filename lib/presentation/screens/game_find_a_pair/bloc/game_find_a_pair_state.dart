part of 'game_find_a_pair_bloc.dart';

enum GameFindAPairStatus { initial, success, congratulation, failure }

final class GameFindAPairState {
  const GameFindAPairState({
    this.status = GameFindAPairStatus.initial,
    this.babyCards = const [],
    this.gameFindAPair,
    this.error,
  });
  final GameFindAPairStatus status;
  final List<BabyCard> babyCards;
  final GameFindAPair? gameFindAPair;

  final String? error;

  GameFindAPairState copyWith({
    GameFindAPairStatus? status,
    List<BabyCard>? babyCards,
    GameFindAPair? gameFindAPair,
    String? error,
  }) {
    return GameFindAPairState(
      status: status ?? this.status,
      babyCards: babyCards ?? this.babyCards,
      gameFindAPair: gameFindAPair ?? this.gameFindAPair,
      error: error ?? this.error,
    );
  }
}
