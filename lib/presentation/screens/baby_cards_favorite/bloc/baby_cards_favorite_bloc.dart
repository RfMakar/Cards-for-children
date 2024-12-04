import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'baby_cards_favorite_event.dart';
part 'baby_cards_favorite_state.dart';

class BabyCardsFavoriteBloc
    extends Bloc<BabyCardsFavoriteEvent, BabyCardsFavoriteState> {
  BabyCardsFavoriteBloc(this._babyCardRepository)
      : super(BabyCardsFavoriteState()) {
    on<BabyCardsFavoriteInitialization>(_onInitialization);
  }
  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    BabyCardsFavoriteInitialization event,
    Emitter<BabyCardsFavoriteState> emit,
  ) async {
    emit(state.copyWith(status: BabyCardsFavoriteStatus.loading));
    final res = await _babyCardRepository.getBabyCardsFavorite();
    if (res.success) {
      emit(state.copyWith(
        status: BabyCardsFavoriteStatus.success,
        babyCardsFavorite: res.data,
      ));
    } else {
      emit(state.copyWith(
        status: BabyCardsFavoriteStatus.failure,
        error: res.message,
      ));
    }
  }
}
