import 'package:busycards/presentation/screens/cards/cards.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/:idCategory',
      builder: (context, state) => CardsScreen(
        idCategory: state.pathParameters['idCategory']!,
      ),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
