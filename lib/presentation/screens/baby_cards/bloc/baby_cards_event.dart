part of 'baby_cards_bloc.dart';

@immutable
sealed class BabyCardsEvent {
  const BabyCardsEvent();
}

final class BabyCardsInitialization extends BabyCardsEvent{
  const BabyCardsInitialization(this.categoryId);
  final int categoryId;
}
