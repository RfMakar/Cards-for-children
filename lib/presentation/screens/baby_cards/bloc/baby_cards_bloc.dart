import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'baby_cards_event.dart';
part 'baby_cards_state.dart';

class BabyCardsBloc extends Bloc<BabyCardsEvent, BabyCardsState> {
  BabyCardsBloc(this._babyCardRepository) : super(const BabyCardsState()) {
    on<BabyCardsInitialization>(_onInitialization);
  }
  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    BabyCardsInitialization event,
    Emitter<BabyCardsState> emit,
  ) async {
    emit(state.copyWith(status: BabyCardStatus.loading));
    final res = await _babyCardRepository.getBabyCards(
      categoryId: event.categoryId,
    );
    if (res.success) {
      emit(state.copyWith(
        status: BabyCardStatus.success,
        babyCards: res.data,
      ));
    } else {
      emit(state.copyWith(
        status: BabyCardStatus.failure,
        error: res.message,
      ));
    }
  }
}
