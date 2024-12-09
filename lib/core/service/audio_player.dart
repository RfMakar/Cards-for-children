import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer;

  AudioPlayerService({required AudioPlayer audioPlayer})
      : _audioPlayer = audioPlayer;

  void play(String path) {
    final source = AssetSource(path);
    _audioPlayer.play(source);
  }

  void playList(List<String> paths) {
    final assetsSource = <AssetSource>[];

    for (var path in paths) {
      assetsSource.add(AssetSource(path));
    }

    _audioPlayer.play(assetsSource.first);
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

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
