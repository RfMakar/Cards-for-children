import 'dart:async';
import 'package:busycards/model/baby_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class ProviderCardImage extends ChangeNotifier {
  ProviderCardImage(this._babyCard, this._babyCardCorrect, this.restartGame) {
    comparison = (_babyCard.name == _babyCardCorrect.name);
    pathImage = _babyCard.image;
    _load();
  }
  final BabyCard _babyCard; //Обьект карточки
  final BabyCard _babyCardCorrect; //Правильная карточка
  final Function restartGame; //Рестарт игры
  late bool comparison; //Сравнение карточек
  late String pathImage;

  var clickCardImage = false; //Нажатие на кнопку
  var pathImageStack =
      'assets/busycard/game/image/question.png'; //Путь к картинке
  var pathImageYes = 'assets/busycard/game/image/yes.png';
  var pathImageNo = 'assets/busycard/game/image/no.png';
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
    pathImageStack = pathImageYes;
    clickCardImage = false;
    notifyListeners();
    listYes.shuffle();
    await player.setAsset(listYes[0]);
    await player.play();
    restartGame();
  }

  void _comparisonNo() async {
    pathImageStack = pathImageNo;
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
