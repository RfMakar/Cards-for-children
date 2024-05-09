// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameStore on _GameStore, Store {
  late final _$babyCardCorrectAtom =
      Atom(name: '_GameStore.babyCardCorrect', context: context);

  @override
  BabyCard get babyCardCorrect {
    _$babyCardCorrectAtom.reportRead();
    return super.babyCardCorrect;
  }

  bool _babyCardCorrectIsInitialized = false;

  @override
  set babyCardCorrect(BabyCard value) {
    _$babyCardCorrectAtom.reportWrite(
        value, _babyCardCorrectIsInitialized ? super.babyCardCorrect : null,
        () {
      super.babyCardCorrect = value;
      _babyCardCorrectIsInitialized = true;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GameStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$babyCardsRandomAtom =
      Atom(name: '_GameStore.babyCardsRandom', context: context);

  @override
  List<BabyCard> get babyCardsRandom {
    _$babyCardsRandomAtom.reportRead();
    return super.babyCardsRandom;
  }

  @override
  set babyCardsRandom(List<BabyCard> value) {
    _$babyCardsRandomAtom.reportWrite(value, super.babyCardsRandom, () {
      super.babyCardsRandom = value;
    });
  }

  late final _$_questionsGameAtom =
      Atom(name: '_GameStore._questionsGame', context: context);

  @override
  List<QuestionGame> get _questionsGame {
    _$_questionsGameAtom.reportRead();
    return super._questionsGame;
  }

  @override
  set _questionsGame(List<QuestionGame> value) {
    _$_questionsGameAtom.reportWrite(value, super._questionsGame, () {
      super._questionsGame = value;
    });
  }

  late final _$_answersGameYesAtom =
      Atom(name: '_GameStore._answersGameYes', context: context);

  @override
  List<AnswerGame> get _answersGameYes {
    _$_answersGameYesAtom.reportRead();
    return super._answersGameYes;
  }

  @override
  set _answersGameYes(List<AnswerGame> value) {
    _$_answersGameYesAtom.reportWrite(value, super._answersGameYes, () {
      super._answersGameYes = value;
    });
  }

  late final _$_answersGameNoAtom =
      Atom(name: '_GameStore._answersGameNo', context: context);

  @override
  List<AnswerGame> get _answersGameNo {
    _$_answersGameNoAtom.reportRead();
    return super._answersGameNo;
  }

  @override
  set _answersGameNo(List<AnswerGame> value) {
    _$_answersGameNoAtom.reportWrite(value, super._answersGameNo, () {
      super._answersGameNo = value;
    });
  }

  late final _$_comparisonYesAsyncAction =
      AsyncAction('_GameStore._comparisonYes', context: context);

  @override
  Future<void> _comparisonYes() {
    return _$_comparisonYesAsyncAction.run(() => super._comparisonYes());
  }

  late final _$_comparisonNoAsyncAction =
      AsyncAction('_GameStore._comparisonNo', context: context);

  @override
  Future<void> _comparisonNo() {
    return _$_comparisonNoAsyncAction.run(() => super._comparisonNo());
  }

  late final _$_getLoadDataAsyncAction =
      AsyncAction('_GameStore._getLoadData', context: context);

  @override
  Future<void> _getLoadData() {
    return _$_getLoadDataAsyncAction.run(() => super._getLoadData());
  }

  late final _$_getBabyCardsRandomAsyncAction =
      AsyncAction('_GameStore._getBabyCardsRandom', context: context);

  @override
  Future<void> _getBabyCardsRandom() {
    return _$_getBabyCardsRandomAsyncAction
        .run(() => super._getBabyCardsRandom());
  }

  late final _$_getQuestionsGameAsyncAction =
      AsyncAction('_GameStore._getQuestionsGame', context: context);

  @override
  Future<void> _getQuestionsGame() {
    return _$_getQuestionsGameAsyncAction.run(() => super._getQuestionsGame());
  }

  late final _$_getAnswersGameNoAsyncAction =
      AsyncAction('_GameStore._getAnswersGameNo', context: context);

  @override
  Future<void> _getAnswersGameNo() {
    return _$_getAnswersGameNoAsyncAction.run(() => super._getAnswersGameNo());
  }

  late final _$_getAnswersGameYesAsyncAction =
      AsyncAction('_GameStore._getAnswersGameYes', context: context);

  @override
  Future<void> _getAnswersGameYes() {
    return _$_getAnswersGameYesAsyncAction
        .run(() => super._getAnswersGameYes());
  }

  late final _$_GameStoreActionController =
      ActionController(name: '_GameStore', context: context);

  @override
  bool onTapCardImage(BabyCard babyCard) {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.onTapCardImage');
    try {
      return super.onTapCardImage(babyCard);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restartGame() {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.restartGame');
    try {
      return super.restartGame();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
babyCardCorrect: ${babyCardCorrect},
isLoading: ${isLoading},
babyCardsRandom: ${babyCardsRandom}
    ''';
  }
}
