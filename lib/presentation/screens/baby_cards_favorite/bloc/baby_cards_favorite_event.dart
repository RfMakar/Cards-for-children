part of 'baby_cards_favorite_bloc.dart';

@immutable
sealed class BabyCardsFavoriteEvent {
  const BabyCardsFavoriteEvent();
}

final class BabyCardsFavoriteInitialization extends BabyCardsFavoriteEvent {
  const BabyCardsFavoriteInitialization();
}
