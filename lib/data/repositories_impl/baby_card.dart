import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/model/baby_card.dart';
import 'package:busycards/data/model/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';

class BabyCardRepositoryImpl implements BabyCardRepository {
  final SqfliteClientApp _sqfliteClientApp;

  BabyCardRepositoryImpl({
    required SqfliteClientApp sqfliteClientApp,
  }) : _sqfliteClientApp = sqfliteClientApp;

  @override
  Future<List<CategoryCardModel>> getCategoriesCards() async {
    final data = await _sqfliteClientApp.getCategoriesCards();
    return data.isNotEmpty
        ? data.map((e) => CategoryCardModel.fromMap(e)).toList()
        : [];
  }

  @override
  Future<List<BabyCardModel>> getCards({required int categoryId}) async {
    final data = await _sqfliteClientApp.getCards(categoryId: categoryId);
    return data.isNotEmpty
        ? data.map((e) => BabyCardModel.fromMap(e)).toList()
        : [];
  }
}
