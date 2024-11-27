import 'package:audioplayers/audioplayers.dart';

Future<void> setupAudio() async {
   AudioCache.instance = AudioCache(prefix: '');
}
