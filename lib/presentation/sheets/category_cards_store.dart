import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'category_cards_store.g.dart';

// ignore: library_private_types_in_public_api
class CategoryCardsStore = _CategoryCardsStore with _$CategoryCardsStore;

abstract class _CategoryCardsStore with Store {
  final BabyCardRepository _babyCardRepository;

  _CategoryCardsStore({
    required BabyCardRepository babyCardRepository,
  }) : _babyCardRepository = babyCardRepository;

  Future<void> init() async {
    await _getCategoriesCards();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  List<CategoryCard> categorysCards = [];

  @action
  Future<void> _getCategoriesCards() async {
    final res = await _babyCardRepository.getCategoriesCards();
    categorysCards = res;
  }
}
