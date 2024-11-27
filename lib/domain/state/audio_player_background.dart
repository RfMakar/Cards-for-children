import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:mobx/mobx.dart';

part 'audio_player_background.g.dart';

// ignore: library_private_types_in_public_api
class AudioPlayerBackgroundStore = _AudioPlayerBackgroundStore
    with _$AudioPlayerBackgroundStore;

abstract class _AudioPlayerBackgroundStore with Store {
  final StorageLocalService _storageLocalService;
  final AudioPlayer _audioPlayer;

  _AudioPlayerBackgroundStore({
    required StorageLocalService storageLocalService,
    required AudioPlayer audioPlayer,
  })  : _storageLocalService = storageLocalService,
        _audioPlayer = audioPlayer;

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
      final source = AssetSource(AppAssetsAudio.audioBackground);
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.play(source, volume: 0.1);
    }
  }

  @action
  Future<void> onOffAudioPlayerBackround() async {
    if (isAudioBackground) {
      _audioPlayer.stop();
      await _storageLocalService.setAudioBackground(!isAudioBackground);
      isAudioBackground = !isAudioBackground;
    } else {
      await _storageLocalService.setAudioBackground(!isAudioBackground);
      isAudioBackground = !isAudioBackground;
      _playAudioBackground();
    }
  }

  Future<void> pauseAudioPlayerBackround() async {
    if (isAudioBackground) {
      _audioPlayer.pause();
    }
  }

  Future<void> resumeAudioPlayerBackround() async {
    if (isAudioBackground) {
      _audioPlayer.resume();
    }
  }

  Future<void> disposeAudioPlayer() async {
    _audioPlayer.dispose();
  }
}
