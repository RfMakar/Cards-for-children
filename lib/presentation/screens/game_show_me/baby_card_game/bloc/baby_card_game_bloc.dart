import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'baby_card_game_event.dart';
part 'baby_card_game_state.dart';

class BabyCardGameBloc extends Bloc<BabyCardGameEvent, BabyCardGameState> {
  BabyCardGameBloc() : super(BabyCardGameState()) {
    on<BabyCardGameInitialization>(_onInitialization);
    on<BabyCardGameOnTapWrong>(_onTapWrong);
    on<BabyCardGameOnTapRight>(_onTapRight);
  }

  void _onInitialization(
    BabyCardGameInitialization event,
    Emitter<BabyCardGameState> emit,
  ) async {
    emit(state.copyWith(status: BabyCardGameStatus.disabled));
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(status: BabyCardGameStatus.enabled));
  }

  void _onTapWrong(
    BabyCardGameOnTapWrong event,
    Emitter<BabyCardGameState> emit,
  ) async {
    emit(state.copyWith(status: BabyCardGameStatus.wrong));
  }

  void _onTapRight(
    BabyCardGameOnTapRight event,
    Emitter<BabyCardGameState> emit,
  ) async {
    emit(state.copyWith(status: BabyCardGameStatus.right));
  }
}
