import 'package:busycards/data/data_sources/remove/fb_firestore.dart';
import 'package:busycards/data/model/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';

class BabyCardRepositoryImpl implements BabyCardRepository {
  final FBFireStore _fbFireStore;

  BabyCardRepositoryImpl({required FBFireStore fbFireStore})
      : _fbFireStore = fbFireStore;

  @override
  Future<List<CategoryCardModel>> getCategoriesCards() async {
    
    return await _fbFireStore.getCategoriesCards();
  }
}
