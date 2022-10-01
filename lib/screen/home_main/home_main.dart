import 'dart:async';

import 'package:busycards/screen/baby_card/screen_baby_cards.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenBabyCards()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextLiquidFill(
          loadDuration: const Duration(seconds: 2),
          text: 'Карточки для детей',
          textAlign: TextAlign.center,
          waveColor: ColorsApp.primary,
          boxBackgroundColor: Colors.white,
          textStyle: GoogleFonts.lobster(
            fontSize: 70,
          ),
        ),
      ),
    );
  }
}
