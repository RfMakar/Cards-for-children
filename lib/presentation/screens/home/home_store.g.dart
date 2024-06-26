// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeStore.isLoading', context: context);

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

  late final _$categorysCardsAtom =
      Atom(name: '_HomeStore.categorysCards', context: context);

  @override
  List<CategoryCard> get categorysCards {
    _$categorysCardsAtom.reportRead();
    return super.categorysCards;
  }

  @override
  set categorysCards(List<CategoryCard> value) {
    _$categorysCardsAtom.reportWrite(value, super.categorysCards, () {
      super.categorysCards = value;
    });
  }

  late final _$_getCategoriesCardsAsyncAction =
      AsyncAction('_HomeStore._getCategoriesCards', context: context);

  @override
  Future<void> _getCategoriesCards() {
    return _$_getCategoriesCardsAsyncAction
        .run(() => super._getCategoriesCards());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
categorysCards: ${categorysCards}
    ''';
  }
}
