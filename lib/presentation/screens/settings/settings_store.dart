import 'package:busycards/domain/state/audio_player_background.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

// ignore: library_private_types_in_public_api
class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final AudioPlayerBackgroundStore _audioPlayerBackgroundStore;

  _SettingsStore({
    required AudioPlayerBackgroundStore audioPlayerBackgroundStore,
  }) : _audioPlayerBackgroundStore = audioPlayerBackgroundStore;

  @computed
  bool get isLoading => _audioPlayerBackgroundStore.isLoading;

  @computed
  bool get isAudioBackground => _audioPlayerBackgroundStore.isAudioBackground;

  @action
  Future<void> onOffAudioPlayerBackround() async =>
      _audioPlayerBackgroundStore.onOffAudioPlayerBackround();
}
