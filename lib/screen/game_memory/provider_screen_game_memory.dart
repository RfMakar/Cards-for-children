import 'dart:async';
import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/widget/style_app.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenGameMemory extends ChangeNotifier {
  ProviderScreenGameMemory() {
    loadGame();
  }
  late List<Color> colorCard; //Начальный цвет 12 карточек
  late List<bool> pressedCard; //Начальное нажатие на 12 карточек
  late Future<Map<int, BabyCard>> listCard; //Начальные картинки
  late List<Map<int, BabyCard>> matchCheck; //Сравнение 2х карточек
  late int properlyReply; //Количество правильных ответов

  final firstColorCard = ColorsApp.primary; //Цвет карточки
  final clickColorCard = Colors.white;
  //Цвет нажатия на карточку

  final trueColorCard = Colors.green; //Цвет правильных карточек
  final falseColorCard = Colors.red; //Цвет неверных карточек
  late AudioPlayer player;

  void loadGame() {
    listCard = list();
    //Показ начальных карточек, через 2 сек перересовываются
    colorCard = List.generate(12, (index) => clickColorCard);
    pressedCard = List.generate(12, (index) => false);

    Future.delayed(const Duration(seconds: 5), () {
      colorCard = List.generate(12, (index) => firstColorCard);
      pressedCard = List.generate(12, (index) => true);
      notifyListeners();
    });
    matchCheck = [];
    properlyReply = 0;
    player = AudioPlayer();
  }

  void restartGame() {
    //Если все пары найдены то обновление игры
    if (properlyReply == 6) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        loadGame();
        notifyListeners();
      });
    }
  }

  void onClick(int index, BabyCard babyCard) async {
    if (matchCheck.length < 2) {
      //После нажатие устанавливает цвет нажатия
      colorCard[index] = clickColorCard;
      //Блокировка нажатой карточки
      pressedCard[index] = false;
      //Добавляет обьекты для сравения
      matchCheck.add({index: babyCard});
      notifyListeners();
    }

    if (matchCheck.length == 2) {
      //Если два обьекта для сравнения, то сравнивает их
      final comparisonCard =
          matchCheck[0].values.first.name == matchCheck[1].values.first.name;

      if (comparisonCard) {
        //Меняет цвет на верные карточки
        updateColorCard(trueColorCard);
        matchCheck.clear();
        properlyReply++;
        playCorrectly();
        restartGame();
      } else {
        //Меняет цвет на неверные карточки
        updateColorCard(falseColorCard);
        playIncorrectly();
        Future.delayed(const Duration(milliseconds: 500), () {
          //Меняет цвет и нажатие на начальный этап
          updateColorCard(firstColorCard);
          pressedCard[matchCheck[0].keys.first] = true;
          pressedCard[matchCheck[1].keys.first] = true;

          matchCheck.clear();
          notifyListeners();
        });
      }
    }
  }

  void updateColorCard(Color color) {
    colorCard[matchCheck[0].keys.first] = color;
    colorCard[matchCheck[1].keys.first] = color;
  }

  //Верно
  void playCorrectly() async {
    await player.setAsset('assets/busycard/game/audio/answer/correctly.mp3');
    player.play();
  }

  //Неверно
  void playIncorrectly() async {
    await player.setAsset('assets/busycard/game/audio/answer/incorrectly.mp3');
    player.play();
  }

  Future<Map<int, BabyCard>> list() async {
    var listFullCards = await DBBabyCards.getListCards();
    listFullCards.shuffle();

    List<BabyCard> listNew = [];
    listNew.add(listFullCards[0]);
    listNew.add(listFullCards[1]);
    listNew.add(listFullCards[2]);
    listNew.add(listFullCards[3]);
    listNew.add(listFullCards[4]);
    listNew.add(listFullCards[5]);
    listNew.add(listFullCards[0]);
    listNew.add(listFullCards[1]);
    listNew.add(listFullCards[2]);
    listNew.add(listFullCards[3]);
    listNew.add(listFullCards[4]);
    listNew.add(listFullCards[5]);

    listNew.shuffle();
    var map = listNew.asMap();

    return map;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
