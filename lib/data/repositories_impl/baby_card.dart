

import 'package:busycards/core/resources/data_state.dart';
import 'package:busycards/data/data_sources/local/db_baby_cards.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';

class BabyCardRepositoryImpl implements BabyCardRepository{

  @override
  Future<DataState<List<CategoryCard>>> getCategoriesCards()async {
   
    final res = await DBBabyCards.getListCategoryCards();

    return DataSuccess(res);
   
  }
  
}