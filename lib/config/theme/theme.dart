import 'package:busycards/config/UI/app_color.dart';
import 'package:flutter/material.dart';

ThemeData get themeData => ThemeData(
      floatingActionButtonTheme: _floatingActionButtonThemeData,
      cardTheme: _cardTheme,
      bottomSheetTheme: _bottomSheetThemeData,
    );

FloatingActionButtonThemeData get _floatingActionButtonThemeData =>
    const FloatingActionButtonThemeData(
      iconSize: 30,
      sizeConstraints: BoxConstraints(
        minHeight: 60,
        minWidth: 60,
      ),
      elevation: 3,
      backgroundColor: AppColor.color,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColor.color2,
          width: 2,
        ),
      ),
    );

CardTheme get _cardTheme => CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      color: AppColor.color2,
      surfaceTintColor: AppColor.color2,
    );

BottomSheetThemeData get _bottomSheetThemeData => const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
