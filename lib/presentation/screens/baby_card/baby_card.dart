import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class BabyCardScreen extends StatefulWidget {
  const BabyCardScreen({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  State<BabyCardScreen> createState() => _BabyCardScreenState();
}

class _BabyCardScreenState extends State<BabyCardScreen> {
  final player = AudioPlayer();
  @override
  void initState() {
    _loadPlay();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _loadPlay() {
    player.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.asset(widget.babyCard.audio),
          if (widget.babyCard.raw != '')
            AudioSource.asset(widget.babyCard.raw!),
        ],
      ),
    );
    player.play();
  }

  void _onPressedPlay() async {
    await player.setAsset(widget.babyCard.audio);
    player.play();
  }

  void _onPressedPlayRaw() async {
    await player.setAsset(widget.babyCard.raw!);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(widget.babyCard.color).withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _top(),
            _image(),
            _bootom(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton.close(
            onTap: context.pop,
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 6,
          color: AppColor.color2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          widget.babyCard.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _bootom() {
    final isRaw = widget.babyCard.raw != '';
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment:
            isRaw ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
        children: [
          isRaw
              ? AppButton.raw(
                  onTap: _onPressedPlayRaw,
                )
              : Container(),
          AppButton.audio(
            onTap: _onPressedPlay,
          ),
        ],
      ),
    );
  }
}

