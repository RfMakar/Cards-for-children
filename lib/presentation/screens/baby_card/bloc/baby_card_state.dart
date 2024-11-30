part of 'baby_card_bloc.dart';

@immutable
sealed class BabyCardState {
  const BabyCardState();
}

final class BabyCardInitial extends BabyCardState {
  const BabyCardInitial();
}

final class BabyCardLoadInProgress extends BabyCardState {
  const BabyCardLoadInProgress();
}

final class BabyCardLoadSucces extends BabyCardState {
  const BabyCardLoadSucces({required this.babyCard});
  final BabyCard babyCard;
}

final class BabyCardLoadFailed extends BabyCardState {
  const BabyCardLoadFailed(this.message);
  final String message;
}
