import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Текст в приложении
abstract class TextApp {
  //Первичный
  static final primary = GoogleFonts.lobster(fontSize: 18, color: Colors.white);
  //Вторичный
  static final secondary =
      GoogleFonts.lobster(fontSize: 30, color: Colors.white);
  // Текст для AppBar
  static final appBar = GoogleFonts.lobster(fontSize: 24, color: Colors.white);
  //Золотой для наз-я компании
  static final golden =
      GoogleFonts.lobster(fontSize: 30, color: ColorsApp.golden);
  //Черный
  static final back = GoogleFonts.lobster(fontSize: 16, color: Colors.black54);
}

//Цвета в приложении
abstract class ColorsApp {
  // Цвет меню карточек
  static Color menuCards = const Color.fromRGBO(82, 182, 255, 1);
  // Цвет фона меню карточек
  static Color backgroundMenuCards = const Color.fromRGBO(186, 226, 255, 1);
  // Цвет меню игр
  static Color menuGame = const Color.fromRGBO(241, 82, 255, 1);
  // Цвет фона меню игр
  static Color backgroundMenuGame = const Color.fromRGBO(248, 201, 252, 1);
  // Цвет меню звуки
  static Color menuRaw = const Color.fromRGBO(255, 155, 82, 1);
  // Цвет фона меню звуки
  static Color backgroundMenuRaw = const Color.fromRGBO(252, 220, 196, 1);
  // Цвет меню info
  static Color menuInfo = const Color.fromRGBO(87, 212, 87, 1);
  // Цвет фона меню info
  static Color backgroundMenuInfo = const Color.fromRGBO(167, 209, 167, 1);

  //Первичный цвет(Основной)
  static const primary = Color.fromRGBO(82, 182, 255, 1);
  //Вторичный цвет (белый)
  static const secondary = Colors.white;
  //Прозрачный
  static final transparent = Colors.white.withOpacity(0);
  //Золотой
  static const golden = Color.fromRGBO(255, 165, 0, 1);
}
