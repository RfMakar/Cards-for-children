import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'games_menu_store.g.dart';

// ignore: library_private_types_in_public_api
class GamesMenuStore = _GamesMenuStore with _$GamesMenuStore;

abstract class _GamesMenuStore with Store {
  final BabyCardRepository _babyCardRepository;
  final int _categoryId;

  @observable
  bool isLoading = true;

  _GamesMenuStore({
    required BabyCardRepository babyCardRepository,
    required int categoryId,
  })  : _babyCardRepository = babyCardRepository,
        _categoryId = categoryId;

  Future<void> init() async {
    await _getBabyCards();
    isLoading = false;
  }

  int get categoryId => _categoryId;

  @observable
  List<BabyCard> babyCards = [];

  @action
  Future<void> _getBabyCards() async {
    final res = await _babyCardRepository.getBabyCardsRandom(
      categoryId: _categoryId,
      limit: 4
    );
    babyCards = res;
  }
}
