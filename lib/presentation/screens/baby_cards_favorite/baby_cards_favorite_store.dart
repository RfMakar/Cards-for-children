import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'baby_cards_favorite_store.g.dart';

// ignore: library_private_types_in_public_api
class BabyCardsFavoriteStore = _BabyCardsFavoriteStore
    with _$BabyCardsFavoriteStore;

abstract class _BabyCardsFavoriteStore with Store {
  final BabyCardRepository _babyCardRepository;

  _BabyCardsFavoriteStore({
    required BabyCardRepository babyCardRepository,
  }) : _babyCardRepository = babyCardRepository;

  Future<void> init() async {
    await _getBabyCardsFavorite();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  List<BabyCard> babyCardsFavorite = [];

  @action
  Future<void> _getBabyCardsFavorite() async {
    final res = await _babyCardRepository.getBabyCardsFavorite();
    babyCardsFavorite = res;
  }
}
