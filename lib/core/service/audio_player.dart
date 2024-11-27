import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<void> setAndPlayAudio(String path) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
  }

  Future<void> setAndPlayAudioList(List<String?> path) async {
    final pathsList = path.whereType<String>().toList();
    final assetsSource = <AssetSource>[];

    for (var path in pathsList) {
      assetsSource.add(AssetSource(path));
    }
    await _audioPlayer.play(assetsSource.first);
    int i = 1;
    _audioPlayer.onPlayerComplete.listen(
      (_) async {
        if (i < assetsSource.length) {
          await _audioPlayer.play(assetsSource[i]);
          i++;
        }
      },
    );
  }

  Future<void> setAndPlayAudioBacground(String path) async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(path), volume: 0.1);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
