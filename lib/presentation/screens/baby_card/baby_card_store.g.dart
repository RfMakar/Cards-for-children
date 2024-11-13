// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BabyCardStore on _BabyCardStore, Store {
  late final _$isFavoriteBabyCardsAtom =
      Atom(name: '_BabyCardStore.isFavoriteBabyCards', context: context);

  @override
  bool get isFavoriteBabyCards {
    _$isFavoriteBabyCardsAtom.reportRead();
    return super.isFavoriteBabyCards;
  }

  bool _isFavoriteBabyCardsIsInitialized = false;

  @override
  set isFavoriteBabyCards(bool value) {
    _$isFavoriteBabyCardsAtom.reportWrite(value,
        _isFavoriteBabyCardsIsInitialized ? super.isFavoriteBabyCards : null,
        () {
      super.isFavoriteBabyCards = value;
      _isFavoriteBabyCardsIsInitialized = true;
    });
  }

  late final _$updateFavoriteBabyCardAsyncAction =
      AsyncAction('_BabyCardStore.updateFavoriteBabyCard', context: context);

  @override
  Future<void> updateFavoriteBabyCard() {
    return _$updateFavoriteBabyCardAsyncAction
        .run(() => super.updateFavoriteBabyCard());
  }

  @override
  String toString() {
    return '''
isFavoriteBabyCards: ${isFavoriteBabyCards}
    ''';
  }
}
