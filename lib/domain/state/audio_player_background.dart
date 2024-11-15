import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:mobx/mobx.dart';

part 'audio_player_background.g.dart';

// ignore: library_private_types_in_public_api
class AudioPlayerBackgroundStore = _AudioPlayerBackgroundStore
    with _$AudioPlayerBackgroundStore;

abstract class _AudioPlayerBackgroundStore with Store {
  final StorageLocalService _storageLocalService;
  final AudioPlayerService _audioPlayerServiceBackground;

  _AudioPlayerBackgroundStore({
    required StorageLocalService storageLocalService,
    required AudioPlayerService audioPlayerServiceBackground,
  })  : _storageLocalService = storageLocalService,
        _audioPlayerServiceBackground = audioPlayerServiceBackground;

  Future<void> init() async {
    await _getAudioBackground();
    await _playAudioBackground();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  late bool isAudioBackground;

  Future<void> _getAudioBackground() async {
    isAudioBackground = await _storageLocalService.getAudioBackground();
  }

  Future<void> _playAudioBackground() async {
    if (isAudioBackground) {
      _audioPlayerServiceBackground.setAndPlayAudioBacground(
        AppAssetsAudio.audioBackground,
      );
    }
  }

  @action
  Future<void> onOffAudioPlayerBackround() async {
    if (isAudioBackground) {
      _audioPlayerServiceBackground.stop();
    } else {
      _audioPlayerServiceBackground.setAndPlayAudioBacground(
        AppAssetsAudio.audioBackground,
      );
    }
    await _storageLocalService.setAudioBackground(!isAudioBackground);
    isAudioBackground = !isAudioBackground;
  }

  Future<void> pauseAudioPlayerBackround() async {
    _audioPlayerServiceBackground.pause();
  }

  Future<void> playAudioPlayerBackround() async {
    if (isAudioBackground) {
      _audioPlayerServiceBackground.play();
    }
  }

  Future<void> disposeAudioPlayer() async {
    await _audioPlayerServiceBackground.dispose();
  }
}
