part of 'baby_cards_favorite_bloc.dart';

@immutable
sealed class BabyCardsFavoriteState {
  const BabyCardsFavoriteState();
}

final class BabyCardsFavoriteInitial extends BabyCardsFavoriteState {
  const BabyCardsFavoriteInitial();
}

final class BabyCardsFavoriteLoadInProgress extends BabyCardsFavoriteState {
  const BabyCardsFavoriteLoadInProgress();
}

final class BabyCardsFavoriteLoadSucces extends BabyCardsFavoriteState {
  const BabyCardsFavoriteLoadSucces({required this.babyCardsFavorite});
  final List<BabyCard> babyCardsFavorite;
}

final class BabyCardsFavoriteLoadFailed extends BabyCardsFavoriteState {
  const BabyCardsFavoriteLoadFailed(this.message);
  final String message;
}
