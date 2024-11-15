import 'package:busycards/application.dart';
import 'package:busycards/core/functions/setup_audio_session.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/functions/setup_system_ui.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupAudioSession();
  await setupSystemUI();
  await setupDependencies();
  
  runApp(const Application());
}
