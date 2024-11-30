part of 'baby_cards_bloc.dart';

@immutable
sealed class BabyCardsState {
  const BabyCardsState();
}

final class BabyCardsInitial extends BabyCardsState {
  const BabyCardsInitial();
}

final class BabyCardsLoadInProgress extends BabyCardsState {
  const BabyCardsLoadInProgress();
}

final class BabyCardsLoadSucces extends BabyCardsState {
  const BabyCardsLoadSucces({required this.babyCards});
  final List<BabyCard> babyCards;
}

final class BabyCardsLoadFailed extends BabyCardsState {
  const BabyCardsLoadFailed(this.message);
  final String message;
}
