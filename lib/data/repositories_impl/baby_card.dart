import 'package:busycards/data/model/baby_card.dart';
import 'package:busycards/data/model/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BabyCardRepositoryImpl implements BabyCardRepository {
  final SupabaseClient _supabase;

  BabyCardRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<CategoryCardModel>> getCategoriesCards() async {
    final data = await _supabase.from('categories').select();
    List<CategoryCardModel> list = data.isNotEmpty
        ? data.map((e) => CategoryCardModel.fromMap(e)).toList()
        : [];

    return list;
  }

  @override
  Future<List<BabyCardModel>> getBabysCards({required int categoryId}) async {
    final data = await _supabase
        .from('cards')
        .select(' name, icon, image, audio, color,raw')
        .eq('category_id', categoryId);
    List<BabyCardModel> list = data.isNotEmpty
        ? data.map((e) => BabyCardModel.fromMap(e)).toList()
        : [];
    return list;
  }
}
