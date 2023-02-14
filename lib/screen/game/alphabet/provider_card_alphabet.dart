import 'package:busycards/model/baby_card.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class ProviderCardAlphabet extends ChangeNotifier {
  ProviderCardAlphabet(this.babyCard) {
    path = babyCard.icon;
  }
  final BabyCard babyCard;
  late String path; //Путь к картинке или иконки
  late AudioPlayer audio; //Проигрыватель

  var click = 0; //Опреелят icon или image

  void onTapCard() async {
    if (click == 0) {
      path = babyCard.image;
      audio = AudioPlayer();
      await audio.setAsset(babyCard.audio);
      await audio.play();
      await audio.setAsset(babyCard.raw!);
      await audio.play();
      click = 1;
    } else {
      path = babyCard.icon;
      click = 0;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }
}
