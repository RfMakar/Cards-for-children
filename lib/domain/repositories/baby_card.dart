import 'package:busycards/domain/entities/category_card.dart';

abstract class BabyCardRepository{
  Future<List<CategoryCard>> getCategoriesCards();
}