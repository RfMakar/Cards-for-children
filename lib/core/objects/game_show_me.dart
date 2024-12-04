import 'dart:math';

import 'package:busycards/domain/entities/answer_game.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/question_game.dart';

class GameShowMe {
  final List<BabyCard> babyCards;
  final List<QuestionGame> questionsGame;
  final List<AnswerGame> answersGameYes;
  final List<AnswerGame> answersGameNo;

  late BabyCard selectedBabyCard;
  late List<BabyCard> selectedBabyCards;

  final int _limitCards = 6;

  GameShowMe({
    required this.babyCards,
    required this.questionsGame,
    required this.answersGameYes,
    required this.answersGameNo,
  }) {
    initRestartGame();
  }

  void initRestartGame() {
    _selectBabyCards();
    _selectBabyCard();
  }

  int get _numderRandom => Random().nextInt(_limitCards);

  void _selectBabyCards() {
    babyCards.shuffle();
    selectedBabyCards = babyCards.sublist(0, _limitCards);
  }

  void _selectBabyCard() {
    selectedBabyCard = babyCards[_numderRandom];
  }

  List<String> playQuestion() {
    questionsGame.shuffle();
    return [
      questionsGame.first.audio,
      selectedBabyCard.audio,
      selectedBabyCard.raw,
    ].whereType<String>().toList();
  }

  String playAnswerYes() {
    answersGameYes.shuffle();
    return answersGameYes.first.audio;
  }

  String playAnswerNo() {
    answersGameNo.shuffle();
    return answersGameNo.first.audio;
  }

  bool isCheck(int babyCardId) {
    return selectedBabyCard.id == babyCardId;
  }
}
