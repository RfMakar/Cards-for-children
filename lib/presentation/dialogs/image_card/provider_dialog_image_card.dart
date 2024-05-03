import 'package:busycards/data/model/baby_card.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderDialoImageCard extends ChangeNotifier {
  ProviderDialoImageCard(this.babyCard) {
    loadPlay();
  }
  final BabyCard babyCard;
  final player = AudioPlayer();

  String get image => babyCard.image;
  String get name => babyCard.name;
  String? get raw => babyCard.raw;

  void loadPlay() {
    player.setAudioSource(
      ConcatenatingAudioSource(children: [
        AudioSource.asset(babyCard.audio),
        if (babyCard.raw != null) AudioSource.asset(babyCard.raw!),
      ]),
    );
    player.play();
  }

  void onPressedPlay() async {
    await player.setAsset(babyCard.audio);
    player.play();
  }

  void onPressedPlayRaw() async {
    await player.setAsset(babyCard.raw!);
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
