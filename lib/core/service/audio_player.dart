import 'package:just_audio/just_audio.dart';


class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<void> setAndPlayAudio(String path) async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      }
      await _audioPlayer.setAsset(path);
      await play();
    } catch (e) {
      print('Ошибка воспроизведения');
    }
  }

  Future<void> setAndPlayAudioList(List<String?> paths) async {
    final pathsList = paths.whereType<String>().toList();
    final audiosSource = <AudioSource>[];

    for (var patch in pathsList) {
      audiosSource.add(AudioSource.asset(patch));
    }

    final playlist = ConcatenatingAudioSource(
      children: audiosSource,
    );

    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      }
      await _audioPlayer.setAudioSource(playlist);
      await play();
    } catch (e) {
     print('Ошибка воспроизведения');
    }
  }

  Future<void> setAndPlayAudioBacground(String path) async {
    try {
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.setVolume(0.1);
      await _audioPlayer.setAsset(path);
      await play();
    } catch (e) {
       print('Ошибка воспроизведения');
    }
  }

  Future<void> pause() async {
    if (_audioPlayer.playing) {
       _audioPlayer.pause();
    }
  }

  Future<void> play() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
       print('Ошибка воспроизведения');
    }
  }

  Future<void> stop() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
