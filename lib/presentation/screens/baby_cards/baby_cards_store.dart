import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'baby_cards_store.g.dart';

// ignore: library_private_types_in_public_api
class BabyCardsStore = _BabyCardsStore with _$BabyCardsStore;

abstract class _BabyCardsStore with Store {
  final BabyCardRepository _babyCardRepository;
  final int _categoryId;

  _BabyCardsStore({
    required BabyCardRepository babyCardRepository,
    required int categoryId,
  })  : _babyCardRepository = babyCardRepository,
        _categoryId = categoryId;

  Future<void> init() async {
    await _getBabyCards();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  List<BabyCard> babyCards = [];

  @action
  Future<void> _getBabyCards() async {
    final res = await _babyCardRepository.getBabyCards(
      categoryId: _categoryId,
    );
    babyCards = res;
  }
}
