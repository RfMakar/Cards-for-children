part of 'games_menu_bloc.dart';

enum GamesMenuStatus { initial, loading, success, failure }

final class GamesMenuState {
  const GamesMenuState({
    this.status = GamesMenuStatus.initial,
    this.babyCards = const [],
    this.error,
  });
  final GamesMenuStatus status;
  final List<BabyCard> babyCards;
  final String? error;

  GamesMenuState copyWith({
    GamesMenuStatus? status,
    List<BabyCard>? babyCards,
    String? error,
  }) {
    return GamesMenuState(
      status: status ?? this.status,
      babyCards: babyCards ?? this.babyCards,
      error: error ?? this.error,
    );
  }
}
