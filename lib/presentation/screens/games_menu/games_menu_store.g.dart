// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_menu_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GamesMenuStore on _GamesMenuStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_GamesMenuStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$babyCardsAtom =
      Atom(name: '_GamesMenuStore.babyCards', context: context);

  @override
  List<BabyCard> get babyCards {
    _$babyCardsAtom.reportRead();
    return super.babyCards;
  }

  @override
  set babyCards(List<BabyCard> value) {
    _$babyCardsAtom.reportWrite(value, super.babyCards, () {
      super.babyCards = value;
    });
  }

  late final _$_getBabyCardsAsyncAction =
      AsyncAction('_GamesMenuStore._getBabyCards', context: context);

  @override
  Future<void> _getBabyCards() {
    return _$_getBabyCardsAsyncAction.run(() => super._getBabyCards());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
babyCards: ${babyCards}
    ''';
  }
}
