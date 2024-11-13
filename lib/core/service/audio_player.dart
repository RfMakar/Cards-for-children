import 'package:just_audio/just_audio.dart';
import 'package:busycards/core/service/toast.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<bool> playAudio(String path) async {
    try {
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
      return true;
    } catch (e) {
      ToastService.showToast('Ошибка воспроизведения');
      return false;
    }
  }

  Future playAudioList(List<String?> paths) async {
    final pathsList = paths.whereType<String>().toList();
    final audiosSource = <AudioSource>[];

    for (var patch in pathsList) {
      audiosSource.add(AudioSource.asset(patch));
    }

    final playlist = ConcatenatingAudioSource(
      children: audiosSource,
    );

    try {
      await _audioPlayer.setAudioSource(playlist);
      await _audioPlayer.play();
    } catch (e) {
      ToastService.showToast('Ошибка воспроизведения');
    }
  }


  void dispose() {
    _audioPlayer.dispose();
  }
}
