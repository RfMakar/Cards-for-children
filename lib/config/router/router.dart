import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_card/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards.dart';
import 'package:busycards/presentation/screens/game/game.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:busycards/presentation/screens/parental_control/parental_control.dart';
import 'package:busycards/presentation/screens/settings/settings.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'nome_screen',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'settings_screen',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: 'baby_cards_screen',
      path: '/baby_cards',
      builder: (context, state) {
        final categoryId = state.extra as int;
        return BabyCardsScreen(
          categoryId: categoryId,
        );
      },
    ),
    GoRoute(
      name: 'baby_card_screen',
      path: '/baby_card',
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
      name: 'parental_control_screen',
      path: '/parental_control',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          fullscreenDialog: true,
          opaque: false,
          transitionsBuilder: (_, __, ___, child) => child,
          child: ParentalControlScreen(),
        );
      },
    ),
    GoRoute(
      name: 'game_screen',
      path: '/game',
      builder: (context, state) {
        final categoryId = state.extra as int;
        return GameScreen(
          categoryId: categoryId,
        );
      },
    ),
  ],
);
