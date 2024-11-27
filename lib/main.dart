import 'package:busycards/application.dart';
import 'package:busycards/core/functions/setuo_audio.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/functions/setup_system_ui.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupSystemUI();
  await setupAudio();
  await setupDependencies();
  runApp(const Application());
}
