import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/category_card.dart';

abstract class BabyCardRepository {
  Future<List<CategoryCard>> getCategoriesCards();
  Future<List<BabyCard>> getCards({required int categoryId});
}
