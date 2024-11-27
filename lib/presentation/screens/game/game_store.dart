import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/domain/entities/answer_game.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/question_game.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:mobx/mobx.dart';

part 'game_store.g.dart';

// ignore: library_private_types_in_public_api
class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  final BabyCardRepository _babyCardRepository;
  final GameRepository _gameRepository;
  final AudioPlayer _audioPlayer;
  final int _categoryId;

  final int _numberOfCards = 6;
  final int _gameId = 0;

  @observable
  late BabyCard babyCardCorrect;
  //loading data
  @observable
  bool isLoading = true;
  @observable
  List<BabyCard> babyCardsRandom = [];
  @observable
  List<QuestionGame> _questionsGame = [];
  @observable
  List<AnswerGame> _answersGameYes = [];
  @observable
  List<AnswerGame> _answersGameNo = [];

  _GameStore({
    required BabyCardRepository babyCardRepository,
    required GameRepository gameRepository,
    required AudioPlayer audioPlayer,
    required int categoryId,
  })  : _babyCardRepository = babyCardRepository,
        _gameRepository = gameRepository,
        _audioPlayer = audioPlayer,
        _categoryId = categoryId;

  Future<void> init() async {
    await _getLoadData();
    _initBabyCardCorrect();
    playQuestion();
  }

  int get _numderRandom => Random().nextInt(_numberOfCards);

  void _initBabyCardCorrect() {
    babyCardCorrect = babyCardsRandom[_numderRandom];
  }

  @action
  Future<bool> onTapCardImage(BabyCard babyCard) async {
    final isComparison = babyCard.name == babyCardCorrect.name;
    if (isComparison) {
      _comparisonYes();
      await Future.delayed(Duration(milliseconds: 800));
    } else {
      _comparisonNo();
    }
    return isComparison;
  }

  @action
  void restartGame() {
    isLoading = true;
    init();
  }

  @action
  Future<void> _comparisonYes() async {
    _answersGameYes.shuffle();
    final source = AssetSource(_answersGameYes.first.audio);
    await _audioPlayer.play(source);
  }

  @action
  Future<void> _comparisonNo() async {
    _answersGameNo.shuffle();
    final source = AssetSource(_answersGameNo.first.audio);
    await _audioPlayer.play(source);
  }

  void playQuestion() async {
    _questionsGame.shuffle();

    final assetsPath = [
      _questionsGame.first.audio,
      babyCardCorrect.audio,
      babyCardCorrect.raw,
    ].whereType<String>().toList();
    final assetsSource = <AssetSource>[];

    for (var path in assetsPath) {
      assetsSource.add(AssetSource(path));
    }

    await _audioPlayer.play(assetsSource.first);
    int i = 1;
    _audioPlayer.onPlayerComplete.listen(
      (_) async {
        if (i < assetsSource.length) {
          await _audioPlayer.play(assetsSource[i]);
          i++;
        }
      },
    );
  }

  @action
  Future<void> _getLoadData() async {
    await _getBabyCardsRandom();
    await _getQuestionsGame();
    await _getAnswersGameNo();
    await _getAnswersGameYes();
    isLoading = false;
  }

  @action
  Future<void> _getBabyCardsRandom() async {
    final res = await _babyCardRepository.getBabyCardsRandom(
      categoryId: _categoryId,
      limit: _numberOfCards,
    );
    babyCardsRandom = res;
  }

  @action
  Future<void> _getQuestionsGame() async {
    final res = await _gameRepository.getQuestionsGame(
      gameId: _gameId,
    );
    if (res.success) {
      _questionsGame = res.data!;
    }
  }

  @action
  Future<void> _getAnswersGameNo() async {
    final res = await _gameRepository.getAnswersGame(
      gameId: _gameId,
      result: 0,
    );
    if (res.success) {
      _answersGameNo = res.data!;
    }
  }

  @action
  Future<void> _getAnswersGameYes() async {
    final res = await _gameRepository.getAnswersGame(
      gameId: _gameId,
      result: 1,
    );
    if (res.success) {
      _answersGameYes = res.data!;
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
