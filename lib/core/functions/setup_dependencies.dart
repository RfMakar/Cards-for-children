import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/core/service/audio_background.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:busycards/data/data_sources/sqflite_client.dart';
import 'package:busycards/data/repositories_impl/baby_card.dart';
import 'package:busycards/data/repositories_impl/game.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:busycards/domain/repositories/game.dart';
import 'package:busycards/presentation/screens/baby_card/bloc/baby_card_bloc.dart';
import 'package:busycards/presentation/screens/baby_cards/bloc/baby_cards_bloc.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/bloc/baby_cards_favorite_bloc.dart';
import 'package:busycards/presentation/screens/game_find_a_pair/bloc/game_find_a_pair_bloc.dart';
import 'package:busycards/presentation/screens/game_show_me/bloc/game_show_me_bloc.dart';
import 'package:busycards/presentation/screens/games_menu/bloc/games_menu_bloc.dart';
import 'package:busycards/presentation/screens/home/bloc/home_bloc.dart';
import 'package:busycards/presentation/screens/settings/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  //audioPlayer
  sl.registerFactory(
    () => AudioPlayer(),
  );

  //sqflite
  sl.registerLazySingleton(
    () => SqfliteClientApp(),
  );

  //services
  sl.registerLazySingleton(
    () => StorageLocalService(),
  );
  sl.registerFactory(
    () => AudioPlayerService(
      audioPlayer: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AudioBackgroundService(
      audioPlayer: sl(),
    ),
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

  //bloc screen
  sl.registerLazySingleton(
    () => HomeBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => BabyCardsBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => BabyCardBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => BabyCardsFavoriteBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => SettingsBloc(
      sl(),
      sl(),
    ),
  );
  sl.registerFactory(
    () => GamesMenuBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => GameShowMeBloc(
      sl(),
      sl(),
      sl(),
    ),
  );

  sl.registerFactory(
    () => GameFindAPairBloc(
      sl(),
      sl(),
    ),
  );
}
