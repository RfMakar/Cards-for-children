import 'package:busycards/config/router/router.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Карточки для детей',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
