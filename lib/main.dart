import 'package:busycards/application.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencie();
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [SystemUiOverlay.bottom],
  // );
  runApp(const Application());
}
