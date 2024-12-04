import 'package:busycards/core/resources/data_state.dart';
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
  Future<DataState<List<CategoryCardModel>>> getCategoriesCards() async {
    try {
      final dataMap = await _sqfliteClientApp.getCategoriesCards();
      final List<CategoryCardModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => CategoryCardModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<BabyCardModel>>> getBabyCards({
    required int categoryId,
  }) async {
    try {
      final dataMap =
          await _sqfliteClientApp.getBabyCards(categoryId: categoryId);
      final List<BabyCardModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => BabyCardModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<BabyCardModel>>> getBabyCardsFavorite() async {
    try {
      final dataMap = await _sqfliteClientApp.getBabyCardsFavorite();
      final List<BabyCardModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => BabyCardModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<bool>> updateBabyCard({
    required int babyCardId,
    required bool isFavorite,
  }) async {
    try {
      final data = await _sqfliteClientApp.putBabyCard(
        babyCardId,
        isFavorite ? 1 : 0,
      );
      return DataSuccess(data > 0 ? true : false);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<BabyCardModel>>> getBabyCardsRandom({
    required int categoryId,
    required int limit,
  }) async {
    try {
      final dataMap = await _sqfliteClientApp.getBabyCardsRandom(
        categoryId: categoryId,
        limit: limit,
      );
      final List<BabyCardModel> data = dataMap.isNotEmpty
          ? dataMap.map((e) => BabyCardModel.fromJson(e)).toList()
          : [];
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
