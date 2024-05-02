import 'package:busycards/config/theme/theme.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/screen_cards.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: ScreenCards(
        menu: Menu.start(),
      ),
    );
  }
}
