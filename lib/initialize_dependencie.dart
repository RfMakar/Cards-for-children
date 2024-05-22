import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/data/repositories_impl/game.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/core/service/cache_manager.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards_store.dart';
import 'package:busycards/presentation/screens/game/game_store.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencie() async {
  //services
  sl.registerLazySingleton<AudioPlayerService>(
    () => AudioPlayerService(sl(),),
    dispose: (audioPlayer) => audioPlayer.dispose(),
  );
  sl.registerLazySingleton<CacheManagerAudio>(
    () => CacheManagerAudio(),
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
    )..init(),
  );
  sl.registerFactoryParam<BabyCardsStore, int, void>(
    (categoryId, _) => BabyCardsStore(
      babyCardRepository: sl(),
      categoryId: categoryId,
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
}
