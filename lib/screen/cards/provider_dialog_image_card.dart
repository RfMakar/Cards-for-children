import 'package:busycards/model/baby_card.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderDialoImageCard extends ChangeNotifier {
  ProviderDialoImageCard(this.babyCard) {
    onPressedPlay();
  }
  final BabyCard babyCard;
  final playerAudio = AudioPlayer();
  final playerRaw = AudioPlayer();

  String get image => babyCard.image;
  String get name => babyCard.name;
  String? get raw => babyCard.raw;

  void onPressedPlay() async {
    await playerAudio.setAsset(babyCard.audio);
    playerAudio.play();
  }

  void onPressedPlayRaw() async {
    await playerRaw.setAsset(raw!);
    playerRaw.play();
  }

  @override
  void dispose() {
    playerAudio.dispose();
    playerRaw.dispose();
    super.dispose();
  }
}
