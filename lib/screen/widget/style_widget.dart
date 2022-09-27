import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class StyleWidget {
  static final styleIconButton = ElevatedButton.styleFrom(
    elevation: 3,
    fixedSize: const Size(60, 60),
    shape: const CircleBorder(),
    primary: const Color.fromRGBO(88, 213, 243, 0.8),
  );

  static final textStyle =
      GoogleFonts.lobster(fontSize: 20, color: Colors.white);

  static final textStyleMenu =
      GoogleFonts.lobster(fontSize: 30, color: Colors.white);
  static final textStyleGame = GoogleFonts.lobster(
      fontSize: 40, color: const Color.fromRGBO(88, 213, 243, 0.8));

  static final textStyleGameMenu = GoogleFonts.lobster(
      fontSize: 16, color: const Color.fromRGBO(88, 213, 243, 1));
}
