import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/presentation/sheets/category_cards_store.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencie() async {
  //base
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  //repositories
  sl.registerLazySingleton<BabyCardRepository>(
    () => BabyCardRepositoryImpl(
      supabase: sl(),
    ),
  );
  //stores
  sl.registerLazySingleton<CategoryCardsStore>(
    () => CategoryCardsStore(
      babyCardRepository: sl(),
    )..init(),
  );
}
