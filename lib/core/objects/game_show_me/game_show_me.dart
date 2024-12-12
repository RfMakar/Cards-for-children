import 'dart:math';

import 'package:busycards/core/objects/game_show_me/game_show_me_card.dart';
import 'package:busycards/domain/entities/answer_game.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/question_game.dart';

class GameShowMe {
  final List<BabyCard> _babyCards;
  final List<QuestionGame> _questionsGame;
  final List<AnswerGame> _answersGameYes;
  final List<AnswerGame> _answersGameNo;

  late BabyCard selectedBabyCard;
  final List<GameShowMeCard> gameShowMeCards = [];

  final int _limitCards = 6;

  GameShowMe({
    required List<BabyCard> babyCards,
    required List<QuestionGame> questionsGame,
    required List<AnswerGame> answersGameYes,
    required List<AnswerGame> answersGameNo,
  })  : _answersGameNo = answersGameNo,
        _answersGameYes = answersGameYes,
        _questionsGame = questionsGame,
        _babyCards = babyCards {
    initRestartGame();
  }

  void initRestartGame() {
    _selectBabyCards();
    _selectBabyCard();
  }

  int get _numderRandom => Random().nextInt(_limitCards);

  void _selectBabyCards() {
    _babyCards.shuffle();
    final selectCards = _babyCards.sublist(0, _limitCards);
    gameShowMeCards.clear();
    for (var element in selectCards) {
      gameShowMeCards.add(
        GameShowMeCard(
          id: element.id,
          icon: element.icon,
          color: element.color,
          audio: element.audio,
          raw: element.raw,
        ),
      );
    }
  }

  void _selectBabyCard() {
    selectedBabyCard = _babyCards[_numderRandom];
  }

  List<String> playQuestion() {
    _questionsGame.shuffle();
    return [
      _questionsGame.first.audio,
      selectedBabyCard.audio,
      selectedBabyCard.raw,
    ].whereType<String>().toList();
  }

  String playAnswerYes() {
    _answersGameYes.shuffle();
    return _answersGameYes.first.audio;
  }

  String playAnswerNo() {
    _answersGameNo.shuffle();
    return _answersGameNo.first.audio;
  }

  bool isCheck(int babyCardId) {
    return selectedBabyCard.id == babyCardId;
  }

  Future<void> installStatusCardsEnabled() async {
    await Future.delayed(const Duration(seconds: 2));
    for (var element in gameShowMeCards) {
      element.status = GameShowMeCardStatus.enabled;
    }
  }

  void installStatusCardsDisabled() {
    for (var element in gameShowMeCards) {
      element.status = GameShowMeCardStatus.disabled;
    }
  }

  void installStatusRight(int gameShowMeCardId) {
    for (var element in gameShowMeCards) {
      if (element.id == gameShowMeCardId) {
        element.status = GameShowMeCardStatus.right;
      }
    }
  }

  void installStatusWrong(int gameShowMeCardId) {
    for (var element in gameShowMeCards) {
      if (element.id == gameShowMeCardId) {
        element.status = GameShowMeCardStatus.wrong;
      }
    }
  }
}
