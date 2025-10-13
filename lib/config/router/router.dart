import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_card/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/baby_cards_favorite.dart';
import 'package:busycards/presentation/screens/congratulation/congratulation.dart';
import 'package:busycards/presentation/screens/game_find_a_pair/game_find_a_pair.dart';
import 'package:busycards/presentation/screens/game_show_me/game_show_me.dart';
import 'package:busycards/presentation/screens/games_menu/games_menu.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:busycards/presentation/screens/parental_control/parental_control.dart';
import 'package:busycards/presentation/screens/settings/settings.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: RouterPath.pathHomeScreen,
  routes: [
    GoRoute(
      path: RouterPath.pathHomeScreen,
      // builder: (context, state) => const HomeScreen(), // c рекламой
      builder: (context, state) => const HomeNoAdsScreen(), //без рекламы
      routes: [
        GoRoute(
          name: RouterPath.pathBabyCardsScreen,
          path: RouterPath.pathBabyCardsScreen,
          builder: (context, state) {
            final categoryId = state.extra as int;
            return BabyCardsScreen(
              categoryId: categoryId,
            );
          },
          routes: [
            GoRoute(
              name: RouterPath.pathBabyCardScreen,
              path: RouterPath.pathBabyCardScreen,
              pageBuilder: (context, state) {
                final babyCard = state.extra as BabyCard;
                return CustomTransitionPage(
                  fullscreenDialog: true,
                  opaque: false,
                  transitionsBuilder: (_, __, ___, child) => child,
                  child: BabyCardScreen(
                    babyCard: babyCard,
                  ),
                );
              },
            ),
            GoRoute(
              name: RouterPath.pathGamesMenuScreen,
              path: RouterPath.pathGamesMenuScreen,
              pageBuilder: (context, state) {
                final babyCards = state.extra as List<BabyCard>;
                return CustomTransitionPage(
                  fullscreenDialog: true,
                  opaque: false,
                  transitionsBuilder: (_, __, ___, child) => child,
                  child: GamesMenuScreen(babyCards: babyCards),
                );
              },
              routes: [
                GoRoute(
                  name: RouterPath.pathGameShowMeScreen,
                  path: RouterPath.pathGameShowMeScreen,
                  builder: (context, state) {
                    final babyCards = state.extra as List<BabyCard>;
                    return GameShowMeScreen(
                      babyCards: babyCards,
                    );
                  },
                ),
                GoRoute(
                  name: RouterPath.pathGameFindAPairScreen,
                  path: RouterPath.pathGameFindAPairScreen,
                  builder: (context, state) {
                    final babyCards = state.extra as List<BabyCard>;
                    return GameFindAPairScreen(
                      babyCards: babyCards,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: RouterPath.pathParentalControlScreen,
          path: RouterPath.pathParentalControlScreen,
          builder: (context, state) {
            return const ParentalControlScreen();
          },
          routes: [
            GoRoute(
              name: RouterPath.pathSettingsScreen,
              path: RouterPath.pathSettingsScreen,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
        GoRoute(
          name: RouterPath.pathFavoriteBabyCardsScreen,
          path: RouterPath.pathFavoriteBabyCardsScreen,
          builder: (context, state) => const BabyCardsFavoriteScreen(),
        ),
        GoRoute(
          name: RouterPath.pathCongratulationScreen,
          path: RouterPath.pathCongratulationScreen,
          pageBuilder: (context, state) {
            final color = state.extra as int;
            return CustomTransitionPage(
              fullscreenDialog: true,
              opaque: false,
              transitionsBuilder: (_, __, ___, child) => child,
              child: CongratulationScreen(color: color),
            );
          },
        ),
      ],
    ),
  ],
);
