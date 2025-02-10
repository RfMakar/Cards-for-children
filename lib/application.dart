import 'package:busycards/config/router/router.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_background.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  final _audioBackground = sl<AudioBackgroundService>();
  final _storageLocalService = sl<StorageLocalService>();

  Future _play() async {
    final isPlay = await _storageLocalService.getAudioBackground();
    if (isPlay) {
      _audioBackground.play();
    }
  }

  Future _pause() async {
    final isPlay = await _storageLocalService.getAudioBackground();
    if (isPlay) {
      _audioBackground.pause();
    }
  }

  Future _resume() async {
    final isPlay = await _storageLocalService.getAudioBackground();
    if (isPlay) {
      _audioBackground.resume();
    }
  }

  @override
  void initState() {
    super.initState();
    _play();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    _audioBackground.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pause();
    }
    if (state == AppLifecycleState.resumed) {
      _resume();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Карточки для детей',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
    );
  }
}
