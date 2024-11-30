import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/config/UI/app_assets.dart';

class AudioBackgroundService {
  final AudioPlayer _audioPlayer;

  AudioBackgroundService({
    required AudioPlayer audioPlayer,
  }) : _audioPlayer = audioPlayer;

  Future play() async {
    final assetSource = AssetSource(AppAssetsAudio.audioBackground);
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(assetSource, volume: 0.1);
  }

  void resume() {
    _audioPlayer.resume();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
