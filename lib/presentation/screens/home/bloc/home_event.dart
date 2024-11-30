part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class HomeInitialization extends HomeEvent {
  const HomeInitialization();
}
