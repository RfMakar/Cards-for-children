import 'dart:async';
import 'dart:math';
import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenGameWhere extends ChangeNotifier {
  late BabyCard babyCardCorrect; //Правильная карточка(выбранная)
  late AudioPlayer playerQuestion;
  final listQuestion = [
    'assets/busycard/game/audio/question/questionfindwhere.mp3',
    'assets/busycard/game/audio/question/questionguesswhere.mp3',
    'assets/busycard/game/audio/question/questionshowwhere.mp3',
  ];

  void playQuestion() async {
    playerQuestion = AudioPlayer();
    listQuestion.shuffle();
    await playerQuestion.setAsset(listQuestion[0]);
    await playerQuestion.play();
    await playerQuestion.setAsset(babyCardCorrect.audio);
    await playerQuestion.play();
  }

  void restartGame() {
    Future.delayed(const Duration(milliseconds: 400), () {
      notifyListeners();
    });
  }

  Future<List<BabyCard>> list() async {
    var listFullCards = await DBBabyCards.getListCards();
    listFullCards.shuffle();

    List<BabyCard> listNew = [];
    listNew.add(listFullCards[0]);
    listNew.add(listFullCards[1]);
    listNew.add(listFullCards[2]);
    listNew.add(listFullCards[3]);

    var random = Random().nextInt(listNew.length);
    babyCardCorrect = listNew[random];

    playQuestion();

    return listNew;
  }

  @override
  void dispose() {
    playerQuestion.dispose();
    super.dispose();
  }
}
