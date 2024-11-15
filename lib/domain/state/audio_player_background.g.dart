// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_background.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AudioPlayerBackgroundStore on _AudioPlayerBackgroundStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_AudioPlayerBackgroundStore.isLoading', context: context);

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

  late final _$isAudioBackgroundAtom = Atom(
      name: '_AudioPlayerBackgroundStore.isAudioBackground', context: context);

  @override
  bool get isAudioBackground {
    _$isAudioBackgroundAtom.reportRead();
    return super.isAudioBackground;
  }

  bool _isAudioBackgroundIsInitialized = false;

  @override
  set isAudioBackground(bool value) {
    _$isAudioBackgroundAtom.reportWrite(
        value, _isAudioBackgroundIsInitialized ? super.isAudioBackground : null,
        () {
      super.isAudioBackground = value;
      _isAudioBackgroundIsInitialized = true;
    });
  }

  late final _$onOffAudioPlayerBackroundAsyncAction = AsyncAction(
      '_AudioPlayerBackgroundStore.onOffAudioPlayerBackround',
      context: context);

  @override
  Future<void> onOffAudioPlayerBackround() {
    return _$onOffAudioPlayerBackroundAsyncAction
        .run(() => super.onOffAudioPlayerBackround());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isAudioBackground: ${isAudioBackground}
    ''';
  }
}
