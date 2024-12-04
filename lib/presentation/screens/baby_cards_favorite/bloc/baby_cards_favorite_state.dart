part of 'baby_cards_favorite_bloc.dart';

enum BabyCardsFavoriteStatus { initial, loading, success, failure }

final class BabyCardsFavoriteState {
  const BabyCardsFavoriteState({
    this.status = BabyCardsFavoriteStatus.initial,
    this.babyCardsFavorite = const [],
    this.error,
  });
  final BabyCardsFavoriteStatus status;
  final List<BabyCard> babyCardsFavorite;
  final String? error;

  BabyCardsFavoriteState copyWith(
      {BabyCardsFavoriteStatus? status,
      List<BabyCard>? babyCardsFavorite,
      String? error}) {
    return BabyCardsFavoriteState(
      status: status ?? this.status,
      babyCardsFavorite: babyCardsFavorite ?? this.babyCardsFavorite,
      error: error ?? this.error,
    );
  }
}
