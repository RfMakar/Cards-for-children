part of 'baby_cards_bloc.dart';

enum BabyCardStatus { initial, loading, success, failure }

final class BabyCardsState {
  const BabyCardsState({
    this.status = BabyCardStatus.initial,
    this.babyCards = const [],
    this.error,
  });
  final BabyCardStatus status;
  final List<BabyCard> babyCards;
  final String? error;

  BabyCardsState copyWith({
    BabyCardStatus? status,
    List<BabyCard>? babyCards,
    String? error,
  }) {
    return BabyCardsState(
      status: status ?? this.status,
      babyCards: babyCards ?? this.babyCards,
      error: error ?? this.error,
    );
  }
}
