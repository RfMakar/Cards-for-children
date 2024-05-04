import 'package:busycards/config/theme/theme.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      // home: CreateBDScreen(),
      home: const HomeScreen(idCategory: 0,),
    );
  }
}
