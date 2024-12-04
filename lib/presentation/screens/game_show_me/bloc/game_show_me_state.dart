part of 'game_show_me_bloc.dart';

enum GameShowMeStatus { initial, loading, success, failure }

final class GameShowMeState {
  const GameShowMeState({
    this.status = GameShowMeStatus.initial,
    this.gameShowMe,
    this.error,
  });
  final GameShowMeStatus status;
  final GameShowMe? gameShowMe;
  final String? error;

  GameShowMeState copyWith({
    GameShowMeStatus? status,
    GameShowMe? gameShowMe,
    String? error,
  }) {
    return GameShowMeState(
      status: status ?? this.status,
      gameShowMe: gameShowMe ?? this.gameShowMe,
      error: error ?? this.error,
    );
  }
}
