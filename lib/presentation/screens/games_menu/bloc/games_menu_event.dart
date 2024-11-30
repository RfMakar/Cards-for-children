part of 'games_menu_bloc.dart';

@immutable
sealed class GamesMenuEvent {
  const GamesMenuEvent();
}

final class GamesMenuInitialization extends GamesMenuEvent{
  const GamesMenuInitialization(this.categoryId);
  final int categoryId;
}