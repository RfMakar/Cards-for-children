import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/star.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key, required this.color});
  final int color;

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  late AudioPlayerService _audioPlayerService;
  @override
  void initState() {
    _audioPlayerService = sl<AudioPlayerService>();
    _audioPlayerService.play(AppAssetsAudio.audioGameCongratulation);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => widget.color,
      child: const BodyCongratulationScreen(),
    );
  }
}

class BodyCongratulationScreen extends StatelessWidget {
  const BodyCongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.pop,
      child: Scaffold(
        backgroundColor:  AppColor.backgroundColor,
        body: Stack(
          children: [
            const ImageStarWidget.congratulation(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: AppButton.close(onTap: context.pop),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
