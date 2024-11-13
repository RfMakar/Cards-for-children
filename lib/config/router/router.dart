import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_card/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/baby_cards_favorite.dart';
import 'package:busycards/presentation/screens/game/game.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:busycards/presentation/screens/parental_control/parental_control.dart';
import 'package:busycards/presentation/screens/settings/settings.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'baby_cards',
          path: 'baby_cards',
          builder: (context, state) {
            final categoryId = state.extra as int;
            return BabyCardsScreen(
              categoryId: categoryId,
            );
          },
          routes: [
            GoRoute(
              name: 'baby_card',
              path: 'baby_card',
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
              name: 'game',
              path: 'game',
              builder: (context, state) {
                final categoryId = state.extra as int;
                return GameScreen(
                  categoryId: categoryId,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: 'parental_control',
          path: 'parental_control',
          builder: (context, state) {
            return const ParentalControlScreen();
          },
          routes: [
            GoRoute(
              name: 'settings',
              path: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
        GoRoute(
          name: 'favorite_baby_cards',
          path: 'favorite_baby_cards',
          builder: (context, state) => const BabyCardsFavoriteScreen(),
        ),
      ],
    ),
  ],
);
