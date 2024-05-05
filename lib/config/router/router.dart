import 'package:busycards/presentation/screens/home/home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/0',
  routes: [
    GoRoute(
      path: '/:idCategory',
      builder: (context, state) =>  HomeScreen(
        idCategory: state.pathParameters['idCategory']!,
      ),
    ),
   
  ],
);
