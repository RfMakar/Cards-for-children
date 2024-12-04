part of 'baby_card_game_bloc.dart';

@immutable
sealed class BabyCardGameEvent {
  const BabyCardGameEvent();
}

final class BabyCardGameInitialization extends BabyCardGameEvent {
  const BabyCardGameInitialization();
}

final class BabyCardGameOnTapRight extends BabyCardGameEvent {
  const BabyCardGameOnTapRight();
}

final class BabyCardGameOnTapWrong extends BabyCardGameEvent {
  const BabyCardGameOnTapWrong();
}
