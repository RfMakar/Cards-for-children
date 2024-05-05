import 'package:busycards/config/router/router.dart';
import 'package:busycards/config/theme/theme.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: themeData,
      debugShowCheckedModeBanner: false,
    
      
    );
  }
}
