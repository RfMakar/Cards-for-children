import 'package:busycards/application.dart';
import 'package:busycards/core/functions/setup_audio_session.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  await setupDependencies();
  await setupAudioSession();
  runApp(const Application());
}
