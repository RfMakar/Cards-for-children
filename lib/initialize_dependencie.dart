import 'package:busycards/data/data_sources/remove/fb_firestore.dart';
import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/presentation/sheets/category_cards_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencie() async {
  //firebase
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  sl.registerLazySingleton<FBFireStore>(
    () => FBFireStore(
      firebaseFirestore: sl(),
    ),
  );
  //repositories
  sl.registerLazySingleton<BabyCardRepository>(
    () => BabyCardRepositoryImpl(
      fbFireStore: sl(),
    ),
  );
  //stores
  sl.registerLazySingleton<CategoryCardsStore>(
    () => CategoryCardsStore(
      babyCardRepository: sl(),
    )..init(),
  );
}
