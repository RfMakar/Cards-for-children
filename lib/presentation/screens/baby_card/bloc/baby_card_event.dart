part of 'baby_card_bloc.dart';

@immutable
sealed class BabyCardEvent {
  const BabyCardEvent();
}

final class BabyCardInitialization extends BabyCardEvent {
  const BabyCardInitialization({required this.babyCard});
  final BabyCard babyCard;
}

final class BabyCardsIsFavorite extends BabyCardEvent{
  const BabyCardsIsFavorite({required this.babyCard});
  final BabyCard babyCard;
}
