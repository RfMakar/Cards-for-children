import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:busycards/core/service/toast.dart';

class AudioPlayerService {
  final _audioPlayer = AssetsAudioPlayer();

  Future<void> playAudio(String path) async {
    try {
      final playable = Audio(path);
      _audioPlayer.open(playable);
    } catch (e) {
      ToastService.showToast('Ошибка воспроизведения');
      return;
    }
  }

  Future<void> playAudioList(List<String?> paths) async {
    final urlsList = paths.whereType<String>().toList();

    try {
      final List<Audio> audios = [];

      for (var path in urlsList) {
        final playable = Audio(path);
        audios.add(playable);
      }

      final playList = Playlist(audios: audios);
      _audioPlayer.open(playList);
    } catch (e) {
      ToastService.showToast('Ошибка воспроизведения');
      return;
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}


/*
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:busycards/core/service/cache_manager.dart';
import 'package:busycards/core/service/toast.dart';

class AudioPlayerService {
  final CacheManagerAudio _cacheManagerAudio;
  final _audioPlayer = AssetsAudioPlayer();
  AudioPlayerService(this._cacheManagerAudio);

  Future<void> playAudio(String url) async {
    final cacheFile = await _cacheManagerAudio.getFileCache(url);
    try {
      final playable = Audio.file(cacheFile!.path);
      _audioPlayer.open(playable);
    } catch (e) {
      ToastService.showToast('Ошибка загрузки');
      return;
    }
  }

  Future<void> playAudioList(List<String?> urls) async {
    final urlsList = urls.whereType<String>().toList();

    try {
      final List<Audio> audios = [];

      for (var url in urlsList) {
        final cacheFile = await _cacheManagerAudio.getFileCache(url);
        final playable = Audio.file(cacheFile!.path);
        audios.add(playable);
      }

      final playList = Playlist(audios: audios);
      _audioPlayer.open(playList);
    } catch (e) {
      ToastService.showToast('Ошибка загрузки');
      return;
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

*/