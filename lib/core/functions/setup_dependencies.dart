import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/data/repositories_impl/game.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/entities/parental_control.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:busycards/presentation/screens/baby_card/baby_card_store.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards_store.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/baby_cards_favorite_store.dart';
import 'package:busycards/presentation/screens/game/game_store.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:busycards/presentation/screens/parental_control/parental_control_store.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  //services
  sl.registerFactory<AudioPlayerService>(
    () => AudioPlayerService(),
  );

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
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(
      sqfliteClientApp: sl(),
    ),
  );
  //stores
  sl.registerLazySingleton<HomeStore>(
    () => HomeStore(
      babyCardRepository: sl(),
      audioPlayerService: sl(),
    )..init(),
  );
  sl.registerFactoryParam<BabyCardStore, BabyCard, void>(
    (babyCard, _) => BabyCardStore(
      babyCardRepository: sl(),
      audioPlayerService: sl(),
      babyCard: babyCard,
    )..init(),
  );
  sl.registerFactoryParam<BabyCardsStore, int, void>(
    (categoryId, _) => BabyCardsStore(
      babyCardRepository: sl(),
      categoryId: categoryId,
    )..init(),
  );
  sl.registerFactory<BabyCardsFavoriteStore>(
    () => BabyCardsFavoriteStore(
      babyCardRepository: sl(),
    )..init(),
  );
  sl.registerFactoryParam<GameStore, int, void>(
    (categoryId, _) => GameStore(
      babyCardRepository: sl(),
      gameRepository: sl(),
      audioPlayerService: sl(),
      categoryId: categoryId,
    )..init(),
  );

  sl.registerFactory<ParentalControlStore>(
    () => ParentalControlStore(
      parentalControl: ParentalControl(),
    )..init(),
  );
}
