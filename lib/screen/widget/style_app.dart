import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class StyleWidget {
  static final styleIconButton = ElevatedButton.styleFrom(
    elevation: 3,
    fixedSize: const Size(60, 60),
    shape: const StadiumBorder(
      side: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
    ),
    primary: ColorsApp.secondary,
  );
}

//Текст в приложении
abstract class TextApp {
  //Первичный
  static final primary = GoogleFonts.lobster(fontSize: 18);
//Вторичный
  static final secondary =
      GoogleFonts.lobster(fontSize: 25, color: Colors.white);
}

//Цвета в приложении
abstract class ColorsApp {
  //Первичный цвет
  static const primary = Color.fromRGBO(82, 182, 255, 1);
  //Вторичный цвет (Прозрачный)
  static const secondary = Color.fromRGBO(82, 182, 255, 0.8);
  //Третичный цвет (Белый)
  static const tertiary = Colors.white;
  //Прозрачный
  static final transparent = Colors.white.withOpacity(0);
}
