part of 'game_show_me_bloc.dart';

@immutable
sealed class GameShowMeEvent {
  const GameShowMeEvent();
}

final class GameShowMeInitialization extends GameShowMeEvent {
  const GameShowMeInitialization(this.categoryId);
  final int categoryId;
  final int gameId = 0;
}

final class GameShowMeOnTapCard extends GameShowMeEvent {
  const GameShowMeOnTapCard({required this.gameShowMeCardId});
  final int gameShowMeCardId;
}

final class GameShowMeRestart extends GameShowMeEvent {
  const GameShowMeRestart();
}
