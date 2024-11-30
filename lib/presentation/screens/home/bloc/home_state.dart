part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

final class HomeLoadSucces extends HomeState {
  const HomeLoadSucces({required this.categorysCards});
  final List<CategoryCard> categorysCards;
}

final class HomeLoadFailed extends HomeState {
  const HomeLoadFailed(this.message);
  final String message;
}
