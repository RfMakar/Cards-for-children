part of 'baby_card_game_bloc.dart';

enum BabyCardGameStatus { initial, disabled, enabled, right, wrong, failure }

final class BabyCardGameState {
  const BabyCardGameState({
    this.status = BabyCardGameStatus.initial,
    this.error,
  });
  final BabyCardGameStatus status;
  final String? error;

  BabyCardGameState copyWith({
    BabyCardGameStatus? status,
    String? error,
  }) {
    return BabyCardGameState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
