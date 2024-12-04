part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.categorysCards = const [],
    this.error,
  });
  final HomeStatus status;
  final List<CategoryCard> categorysCards;
  final String? error;

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryCard>? categorysCards,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      categorysCards: categorysCards ?? this.categorysCards,
      error: error ?? this.error,
    );
  }
}
