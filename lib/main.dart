import 'package:busycards/screen/menu_home/screen_menu_home.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  googleFont();
  runApp(const MyApp());
}

void googleFont() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts//OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeApp.themeLight,
      debugShowCheckedModeBanner: false,
      home: const ScreenMenuHome(),
    );
  }
}

abstract class MyThemeApp {
  static final themeLight = ThemeData(
    //Тема карточки
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 3,
    ),
    //Тема AppBar
    appBarTheme: const AppBarTheme(
      toolbarHeight: 50,
      centerTitle: true,
    ),
    //Тема шторки снизу
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedBorderColor: ColorsApp.secondary,
      borderColor: ColorsApp.secondary,
      fillColor: ColorsApp.menuGame,
      borderWidth: 2,
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
    ),
  );
}
