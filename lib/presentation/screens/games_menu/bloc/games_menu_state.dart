part of 'games_menu_bloc.dart';

@immutable
sealed class GamesMenuState {
  const GamesMenuState();
}

final class GamesMenuInitial extends GamesMenuState {
  const GamesMenuInitial();
}

final class GamesMenuLoadInProgress extends GamesMenuState {
  const GamesMenuLoadInProgress();
}

final class GamesMenuLoadSucces extends GamesMenuState {
  const GamesMenuLoadSucces({required this.babyCards});
  final List<BabyCard> babyCards;
}

final class GamesMenuLoadFailed extends GamesMenuState {
  const GamesMenuLoadFailed(this.message);
  final String message;
}
