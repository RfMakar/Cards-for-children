import 'package:busycards/screen/baby_card/screen_baby_cards.dart';
import 'package:busycards/screen/game/screen_game.dart';
import 'package:busycards/screen/settings/screen_settings.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextLiquidFill(
                  text: 'Карточки для детей',
                  textAlign: TextAlign.center,
                  waveColor: const Color.fromRGBO(88, 213, 243, 1),
                  boxBackgroundColor: Colors.white,
                  textStyle: GoogleFonts.lobster(
                    fontSize: 70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ButtonNavigatorScreen(
                  screen: ScreenBabyCards(),
                  name: 'Карточки',
                ),
                ButtonNavigatorScreen(
                  screen: ScreenGame(),
                  name: 'Игры',
                ),
                ButtonNavigatorScreen(
                  screen: ScreenSettings(),
                  name: 'О приложении',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonNavigatorScreen extends StatelessWidget {
  const ButtonNavigatorScreen(
      {Key? key, required this.screen, required this.name})
      : super(key: key);
  final Widget screen;
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(88, 213, 243, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Text(
            name,
            style: StyleWidget.textStyle,
          )),
    );
  }
}
