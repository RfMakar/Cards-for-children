part of 'baby_card_bloc.dart';

enum BabyCardStatus { initial, loading, success, failure }

final class BabyCardState {
  const BabyCardState({
    this.status = BabyCardStatus.initial,
    this.babyCard,
    this.error,
  });
  final BabyCardStatus status;
  final BabyCard? babyCard;
  final String? error;

  BabyCardState copyWith({
    BabyCardStatus? status,
    BabyCard? babyCard,
    String? error,
  }) {
    return BabyCardState(
      status: status ?? this.status,
      babyCard: babyCard ?? this.babyCard,
      error: error ?? this.error,
    );
  }
}
