import 'dart:async';
import 'package:busycards/model/baby_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class ProviderCardImage extends ChangeNotifier {
  ProviderCardImage(this._babyCard, this._babyCardCorrect, this.restartGame) {
    _load();
    comparison = (_babyCard.name == _babyCardCorrect.name);
  }
  final BabyCard _babyCard; //Обьект карточки
  final BabyCard _babyCardCorrect; //Правильная карточка
  final Function restartGame;
  late bool comparison; //Сравнение карточек
  var clickCardImage = false; //Нажатие на кнопку
  var pathImage = 'assets/busycard/game/image/question.png'; //Путь к картинке
  final player = AudioPlayer(); //Проигрыватель
  final listYes = [
    'assets/busycard/game/audio/yes/yescorrectly.mp3',
    'assets/busycard/game/audio/yes/yesexactly.mp3',
    'assets/busycard/game/audio/yes/yesexcellent.mp3',
    'assets/busycard/game/audio/yes/yesgreat.mp3',
    'assets/busycard/game/audio/yes/yesright.mp3',
    'assets/busycard/game/audio/yes/yeswelldone.mp3',
  ];
  final listNo = [
    'assets/busycard/game/audio/no/no.mp3',
    'assets/busycard/game/audio/no/nomistake.mp3',
    'assets/busycard/game/audio/no/notcorrect.mp3',
    'assets/busycard/game/audio/no/notryagain.mp3',
    'assets/busycard/game/audio/no/notsure.mp3'
  ];

  void _comparisonYes() async {
    pathImage = 'assets/busycard/game/image/yes.png';
    clickCardImage = false;
    notifyListeners();
    listYes.shuffle();
    await player.setAsset(listYes[0]);
    await player.play();
    restartGame();
  }

  void _comparisonNo() async {
    pathImage = 'assets/busycard/game/image/no.png';
    clickCardImage = false;
    notifyListeners();
    listNo.shuffle();
    await player.setAsset(listNo[0]);
    await player.play();
  }

  void _load() {
    Future.delayed(const Duration(seconds: 3), () {
      clickCardImage = true;
      pathImage = _babyCard.image;
      notifyListeners();
    });
  }

  void onTapCardImage() {
    if (comparison) {
      _comparisonYes();
    } else {
      _comparisonNo();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
