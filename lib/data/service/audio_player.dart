import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerService {
  final _audioPlayer = AssetsAudioPlayer();

  void audioPlayerPlay(String assetPath) {
    final playable = Audio(assetPath);
    try {
      _audioPlayer.open(playable);
    } catch (e) {
      return;
    }
  }

  void audioPlayerListPlay(List<String?> assetsPath) {
    final assetsList = assetsPath.whereType<String>().toList();
    final audios = assetsList.map((e) => Audio(e)).toList();
    final playList = Playlist(audios: audios);
    try {
      _audioPlayer.open(playList);
    } catch (e) {
      return;
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
