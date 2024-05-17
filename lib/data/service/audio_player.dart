import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:busycards/data/service/cache_manager.dart';

class AudioPlayerService {
  final CacheManagerAudio _cacheManagerAudio;
  final _audioPlayer = AssetsAudioPlayer();
  AudioPlayerService(this._cacheManagerAudio);

  Future<void> audioPlayerPlay(String assetPath) async {
    final cacheFile = await _cacheManagerAudio.getFileCache(assetPath);
    try {
      final playable = Audio.file(cacheFile!.path);
      _audioPlayer.open(playable);
    } catch (e) {
      return;
    }
  }

  Future<void> audioPlayerListPlay(List<String?> assetsPath) async {
    final assetsList = assetsPath.whereType<String>().toList();

    try {
      final List<Audio> audios = [];

      for (var url in assetsList) {
        final cacheFile = await _cacheManagerAudio.getFileCache(url);
        final playable = Audio.file(cacheFile!.path);
        audios.add(playable);
      }

      final playList = Playlist(audios: audios);
      _audioPlayer.open(playList);
    } catch (e) {
      return;
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
