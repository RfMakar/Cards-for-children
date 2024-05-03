import 'package:busycards/core/resources/data_state.dart';
import 'package:busycards/domain/entities/category_card.dart';

abstract class BabyCardRepository{
  Future<DataState<List<CategoryCard>>> getCategoriesCards();
}