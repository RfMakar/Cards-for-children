import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'baby_cards_favorite_event.dart';
part 'baby_cards_favorite_state.dart';

class BabyCardsFavoriteBloc
    extends Bloc<BabyCardsFavoriteEvent, BabyCardsFavoriteState> {
  BabyCardsFavoriteBloc(this._babyCardRepository) : super(BabyCardsFavoriteInitial()) {
    on<BabyCardsFavoriteInitialization>(_onInitialization);
  }
   final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    BabyCardsFavoriteInitialization event,
    Emitter<BabyCardsFavoriteState> emit,
  ) async {
    emit(BabyCardsFavoriteLoadInProgress());
    final res = await _babyCardRepository.getBabyCardsFavorite();
    if (res.success) {
      emit(BabyCardsFavoriteLoadSucces(babyCardsFavorite: res.data!));
    } else {
      emit(BabyCardsFavoriteLoadFailed(res.message!));
    }
  }
}
