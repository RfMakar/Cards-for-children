import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencie() async {
  //sqflite
  sl.registerLazySingleton<SqfliteClientApp>(
    () => SqfliteClientApp(),
  );
  //repositories
  sl.registerLazySingleton<BabyCardRepository>(
    () => BabyCardRepositoryImpl(
      sqfliteClientApp: sl(),
    ),
  );
  //stores
  sl.registerLazySingleton<HomeStore>(
    () => HomeStore(
      babyCardRepository: sl(),
    )..init(),
  );

}

class SupabaseClientAp {}
