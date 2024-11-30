import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'baby_card_event.dart';
part 'baby_card_state.dart';

class BabyCardBloc extends Bloc<BabyCardEvent, BabyCardState> {
  BabyCardBloc(this._babyCardRepository) : super(BabyCardInitial()) {
    on<BabyCardInitialization>(_onInitialization);
    on<BabyCardsIsFavorite>(_onIsFavorite);
  }

  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    BabyCardInitialization event,
    Emitter<BabyCardState> emit,
  ) async {
    emit(BabyCardLoadInProgress());
    emit(BabyCardLoadSucces(babyCard: event.babyCard));
  }

  void _onIsFavorite(
    BabyCardsIsFavorite event,
    Emitter<BabyCardState> emit,
  ) async {
    final babyCard = event.babyCard;
    final res = await _babyCardRepository.updateBabyCard(
      babyCardId: babyCard.id,
      isFavorite: !babyCard.isFavorite,
    );
    if (res.success) {
      emit(
        BabyCardLoadSucces(
          babyCard: babyCard.copyWith(isFavorite: !babyCard.isFavorite),
        ),
      );
    } else {
      emit(BabyCardLoadFailed(res.message!));
    }
  }
}
