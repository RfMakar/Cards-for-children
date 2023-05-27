import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/screen_cards.dart';
import 'package:busycards/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyThemeApp.themeLight,
        debugShowCheckedModeBanner: false,
        home: ScreenCards(menu: Menu.start()));
  }
}

abstract class MyThemeApp {
  static final themeLight = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 30,
      sizeConstraints: const BoxConstraints(minHeight: 60, minWidth: 60),
      elevation: 3,
      backgroundColor: ColorsApp.color,
      shape: StadiumBorder(
        side: BorderSide(
          color: ColorsApp.color2,
          width: 2,
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 3,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    ),
  );
}
