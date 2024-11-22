import 'package:flutter/services.dart';

Future<void> setupSystemUI()async{
   await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
}