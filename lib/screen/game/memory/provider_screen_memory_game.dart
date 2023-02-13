import 'dart:async';
import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/widget/style_app.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenMemoryGame extends ChangeNotifier {
  ProviderScreenMemoryGame(this.idTable) {
    loadGame();
  }
  final int idTable;
  var isSelectTable = [true, false, false];
  final numberOfCards = [4, 6, 12]; //Количество карточек на экране
  late List<Color> colorCard; //Начальный цвет  карточек
  late List<bool> pressedCard; //Начальное нажатие  карточек
  late Future<Map<int, BabyCard>> listCard; //Начальные картинки
  late List<Map<int, BabyCard>> matchCheck; //Сравнение 2х карточек
  late int properlyReply; //Количество правильных ответов

  final firstColorCard = ColorsApp.menuGame; //Цвет карточки
  final clickColorCard = Colors.white;
  //Цвет нажатия на карточку

  final trueColorCard = Colors.green; //Цвет правильных карточек
  final falseColorCard = Colors.red; //Цвет неверных карточек
  late AudioPlayer player;

  //Переключает виджеты таблиц
  void onPressedToggleButtons(int index) {
    for (int i = 0; i < isSelectTable.length; i++) {
      if (i == index) {
        isSelectTable[i] = true;
      } else {
        isSelectTable[i] = false;
      }
    }
    loadGame();
    notifyListeners();
  }

  void loadGame() {
    listCard = list();
    //Показ начальных карточек, через 5 сек перересовываются
    if (isSelectTable[0] == true) {
      colorCard = List.generate(numberOfCards[0], (index) => clickColorCard);
      pressedCard = List.generate(numberOfCards[0], (index) => false);
    } else if (isSelectTable[1] == true) {
      colorCard = List.generate(numberOfCards[1], (index) => clickColorCard);
      pressedCard = List.generate(numberOfCards[1], (index) => false);
    } else {
      colorCard = List.generate(numberOfCards[2], (index) => clickColorCard);
      pressedCard = List.generate(numberOfCards[2], (index) => false);
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (isSelectTable[0] == true) {
        colorCard = List.generate(numberOfCards[0], (index) => firstColorCard);
        pressedCard = List.generate(numberOfCards[0], (index) => true);
      } else if (isSelectTable[1] == true) {
        colorCard = List.generate(numberOfCards[1], (index) => firstColorCard);
        pressedCard = List.generate(numberOfCards[1], (index) => true);
      } else {
        colorCard = List.generate(numberOfCards[2], (index) => firstColorCard);
        pressedCard = List.generate(numberOfCards[2], (index) => true);
      }

      notifyListeners();
    });

    matchCheck = [];
    properlyReply = 0;
    player = AudioPlayer();
  }

  void restartGame() {
    void _restart() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        loadGame();
        notifyListeners();
      });
    }

    //Если все пары найдены то обновление игры
    if ((isSelectTable[0] == true) & (properlyReply == 2)) {
      _restart();
    } else if ((isSelectTable[1] == true) & (properlyReply == 3)) {
      _restart();
    } else if ((isSelectTable[2] == true) & (properlyReply == 6)) {
      _restart();
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
    var listFullCards = await DBBabyCards.getListBabyCards(idTable);
    listFullCards.shuffle();

    List<BabyCard> listNew = [];
    if (isSelectTable[0] == true) {
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
    } else if (isSelectTable[1] == true) {
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
      listNew.add(listFullCards[2]);
      listNew.add(listFullCards[0]);
      listNew.add(listFullCards[1]);
      listNew.add(listFullCards[2]);
    } else {
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
    }

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
