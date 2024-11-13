// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_cards_favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BabyCardsFavoriteStore on _BabyCardsFavoriteStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_BabyCardsFavoriteStore.isLoading', context: context);

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

  late final _$babyCardsFavoriteAtom =
      Atom(name: '_BabyCardsFavoriteStore.babyCardsFavorite', context: context);

  @override
  List<BabyCard> get babyCardsFavorite {
    _$babyCardsFavoriteAtom.reportRead();
    return super.babyCardsFavorite;
  }

  @override
  set babyCardsFavorite(List<BabyCard> value) {
    _$babyCardsFavoriteAtom.reportWrite(value, super.babyCardsFavorite, () {
      super.babyCardsFavorite = value;
    });
  }

  late final _$_getBabyCardsFavoriteAsyncAction = AsyncAction(
      '_BabyCardsFavoriteStore._getBabyCardsFavorite',
      context: context);

  @override
  Future<void> _getBabyCardsFavorite() {
    return _$_getBabyCardsFavoriteAsyncAction
        .run(() => super._getBabyCardsFavorite());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
babyCardsFavorite: ${babyCardsFavorite}
    ''';
  }
}
