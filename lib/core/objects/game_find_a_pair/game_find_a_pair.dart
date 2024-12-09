import 'package:busycards/core/objects/game_find_a_pair/game_find_a_pair_card.dart';
import 'package:busycards/domain/entities/baby_card.dart';

final class GameFindAPair {
  GameFindAPair({
    required List<BabyCard> babyCards,
  }) : _babyCards = babyCards {
    _initGame();
  }
  final List<BabyCard> _babyCards;

  final List<GameFindAPairCard> _gameFindAPairCards = [];
  final int _countBabyCard = 8;
  int _countRight = 0; //количество праивльных карт
  final Map<int, GameFindAPairCard> _checkCards = {}; //проверка двух карточек

  List<GameFindAPairCard> get gameFindAPairCards => _gameFindAPairCards;

  bool get isCheckCard => _checkCards.length == 1;
  bool get restart => _countRight == _countBabyCard;

  void _initGame() {
    _babyCards.shuffle();

    final selectBabyCard = List.of(_babyCards.sublist(0, _countBabyCard));
    selectBabyCard.addAll([...selectBabyCard]);

    for (var i = 0; i < selectBabyCard.length; i++) {
      _gameFindAPairCards.add(
        GameFindAPairCard(
          id: i,
          idCard: selectBabyCard[i].id,
          icon: selectBabyCard[i].icon,
          color: selectBabyCard[i].color,
        ),
      );
    }
    _gameFindAPairCards.shuffle();
  }

  void restartGame() {
    _gameFindAPairCards.clear();
    _countRight = 0;
    _initGame();
  }

  void onTapCard(int gameFindAPairCardId) {
    final index = gameFindAPairCards.indexWhere(
      (el) => el.id == gameFindAPairCardId,
    );
    gameFindAPairCards[index] = gameFindAPairCards[index].copyWith(
      status: GameFindAPairCardStatus.select,
    );
    _checkCards[index] = gameFindAPairCards[index];
  }

  bool examinationCards() {
    if (_isCheck()) {
      _cardsRight();
      return true;
    } else {
      _cardsWrong();
      return false;
    }
  }

  bool _isCheck() {
    final values = _checkCards.values.toList();
    return values[0].idCard == values[1].idCard;
  }

  void _cardsRight()async {
    for (var element in _checkCards.keys) {
      gameFindAPairCards[element] = gameFindAPairCards[element].copyWith(
        status: GameFindAPairCardStatus.right,
      );
    }
    _countRight++;
    _checkCards.clear();
  }

  void _cardsWrong() async {
    for (var element in _checkCards.keys) {
      gameFindAPairCards[element] = gameFindAPairCards[element].copyWith(
        status: GameFindAPairCardStatus.wrong,
      );
    }
  }

  Future<void> cardWrongToEnabled() async {
    await await Future.delayed(const Duration(milliseconds: 200));
    for (var element in _checkCards.keys) {
      gameFindAPairCards[element] = gameFindAPairCards[element].copyWith(
        status: GameFindAPairCardStatus.enabled,
      );
    }
    _checkCards.clear();
  }
}
