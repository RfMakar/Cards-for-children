import 'dart:math';
import 'package:busycards/data/model/baby_card.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenGame extends ChangeNotifier {
  ProviderScreenGame(this.listBabyCard) {
    _load();
  }

  final List<BabyCard> listBabyCard;
  late List<BabyCard> listStar; //Начальные картинки 4шт
  late BabyCard babyCardCorrect; //Правильная карточка(выбранная)

  final listQuestion = [
    'assets/game/audio/question/questionfindwhere.mp3',
    'assets/game/audio/question/questionguesswhere.mp3',
    'assets/game/audio/question/questionshowwhere.mp3',
  ];
  late List<bool> clickCardImage; //Нажатие на кнопку
  late List<String> pathImageStack; //Путь к картинке
  var pathImageYes = 'assets/game/image/yes.png';
  var pathImageNo = 'assets/game/image/no.png';
  //Проигрыватели
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer playerQuestion = AudioPlayer();

  final listYes = [
    'assets/game/audio/yes/yescorrectly.mp3',
    'assets/game/audio/yes/yesexactly.mp3',
    'assets/game/audio/yes/yesexcellent.mp3',
    'assets/game/audio/yes/yesgreat.mp3',
    'assets/game/audio/yes/yesright.mp3',
    'assets/game/audio/yes/yeswelldone.mp3',
  ];
  final listNo = [
    'assets/game/audio/no/no.mp3',
    'assets/game/audio/no/nomistake.mp3',
    'assets/game/audio/no/notcorrect.mp3',
    'assets/game/audio/no/notryagain.mp3',
    'assets/game/audio/no/notsure.mp3'
  ];
  late int random;

  void _load() {
    pathImageStack = [
      'assets/game/image/question.png',
      'assets/game/image/question.png',
      'assets/game/image/question.png',
      'assets/game/image/question.png',
    ];
    clickCardImage = [false, false, false, false];

    listBabyCard.shuffle();
    listStar = [];
    listStar.add(listBabyCard[0]);
    listStar.add(listBabyCard[1]);
    listStar.add(listBabyCard[2]);
    listStar.add(listBabyCard[3]);

    random = Random().nextInt(listStar.length);

    babyCardCorrect = listStar[random];

    playQuestion();

    Future.delayed(const Duration(seconds: 2), () {
      clickCardImage = [true, true, true, true];

      notifyListeners();
    }).catchError((err) {
      // // player.stop();
      // playerQuestion.stop();
    });
  }

  void restartGame() {
    Future.delayed(const Duration(seconds: 2), () {
      _load();
      notifyListeners();
    }).catchError((err) {
      // player.stop();
      // playerQuestion.stop();
    });
  }

  void onTapCardImage(int index) {
    void comparisonYes() async {
      pathImageStack[index] = pathImageYes;
      clickCardImage[index] = false;
      notifyListeners();
      listYes.shuffle();
      await player.setAsset(listYes[0]);
      await player.play();
      restartGame();
    }

    void comparisonNo() async {
      pathImageStack[index] = pathImageNo;
      clickCardImage[index] = false;
      notifyListeners();
      listNo.shuffle();
      await player.setAsset(listNo[0]);
      await player.play();
    }

    final bool comparison = listStar[index].name == babyCardCorrect.name;
    if (comparison) {
      comparisonYes();
    } else {
      comparisonNo();
    }
  }

  void playQuestion() {
    listQuestion.shuffle();
    playerQuestion.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.asset(listQuestion[0]),
      AudioSource.asset(babyCardCorrect.audio),
      if (babyCardCorrect.raw != null) AudioSource.asset(babyCardCorrect.raw!),
    ]));
    playerQuestion.play();
  }

  @override
  void dispose() {
    player.dispose();
    playerQuestion.dispose();
    super.dispose();
  }
}
