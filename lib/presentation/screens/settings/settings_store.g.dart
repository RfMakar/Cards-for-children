// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_SettingsStore.isLoading'))
          .value;
  Computed<bool>? _$isAudioBackgroundComputed;

  @override
  bool get isAudioBackground => (_$isAudioBackgroundComputed ??= Computed<bool>(
          () => super.isAudioBackground,
          name: '_SettingsStore.isAudioBackground'))
      .value;

  late final _$onOffAudioPlayerBackroundAsyncAction =
      AsyncAction('_SettingsStore.onOffAudioPlayerBackround', context: context);

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
