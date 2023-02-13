import 'dart:async';
import 'dart:math';
import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenQuizGame extends ChangeNotifier {
  late BabyCard babyCardCorrect; //Правильная карточка(выбранная)
  late AudioPlayer playerQuestion;
  final listQuestion = [
    'assets/busycard/game/audio/question/questionfindwhere.mp3',
    'assets/busycard/game/audio/question/questionguesswhere.mp3',
    'assets/busycard/game/audio/question/questionshowwhere.mp3',
  ];
  var isSelectTable = [true, false, false];

  //Переключает виджеты таблиц
  void onPressedToggleButtons(int index) {
    for (int i = 0; i < isSelectTable.length; i++) {
      if (i == index) {
        isSelectTable[i] = true;
      } else {
        isSelectTable[i] = false;
      }
    }
    playerQuestion.dispose();
    notifyListeners();
  }

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

  Future<List<BabyCard>> list(int idTable) async {
    var listFullCards = await DBBabyCards.getListBabyCards(idTable);
    listFullCards.shuffle();

    List<BabyCard> listNew = [];

    if (isSelectTable[0] == true) {
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
    } else if (isSelectTable[1] == true) {
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
      listNew.add(listFullCards[2]);
      listNew.add(listFullCards[3]);
    } else {
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
      listNew.add(listFullCards[2]);
      listNew.add(listFullCards[3]);
      listNew.add(listFullCards[4]);
      listNew.add(listFullCards[5]);
    }

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
