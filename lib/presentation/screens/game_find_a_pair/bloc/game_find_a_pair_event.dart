part of 'game_find_a_pair_bloc.dart';

@immutable
sealed class GameFindAPairEvent {
  const GameFindAPairEvent();
}

final class GameFindAPairInitialization extends GameFindAPairEvent {
  const GameFindAPairInitialization(this.babyCards);
  final List<BabyCard> babyCards;
}

final class GameFindAPairOnTap extends GameFindAPairEvent {
  const GameFindAPairOnTap({required this.gameFindAPairId});
  final int gameFindAPairId;
}

final class GameFindAPairRestartGame extends GameFindAPairEvent {
  const GameFindAPairRestartGame();
}
