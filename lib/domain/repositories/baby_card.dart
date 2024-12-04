import 'package:busycards/core/resources/data_state.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/category_card.dart';

abstract class BabyCardRepository {
  Future<DataState<List<CategoryCard>>> getCategoriesCards();
  Future<DataState<List<BabyCard>>> getBabyCards({required int categoryId});
  Future<DataState<List<BabyCard>>> getBabyCardsFavorite();
  Future<DataState<BabyCard>> updateBabyCard({
    required int babyCardId,
    required bool isFavorite,
  });
  Future<DataState<List<BabyCard>>> getBabyCardsRandom({
    required int categoryId,
    required int limit,
  });
}
