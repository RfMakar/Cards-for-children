import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ImageCardDialog extends StatefulWidget {
  const ImageCardDialog({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  State<ImageCardDialog> createState() => _ImageCardDialogState();
}

class _ImageCardDialogState extends State<ImageCardDialog> {
  final player = AudioPlayer();
  @override
  void initState() {
    loadPlay();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void loadPlay() {
    player.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(widget.babyCard.audio),
          ),
          if (widget.babyCard.raw != null)
            AudioSource.uri(
              Uri.parse(widget.babyCard.raw!),
            ),
        ],
      ),
    );
    player.play();
  }

  void onPressedPlay() async {
    await player.setUrl(widget.babyCard.audio);
    player.play();
  }

  void onPressedPlayRaw() async {
    await player.setUrl(widget.babyCard.raw!);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColor.transparent,
      children: [
        //Вверх диалога (Имя карточки)
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: AppColor.color2),
          height: 40,
          child: Center(
              child: Text(
            widget.babyCard.name,
            style: const TextStyle(
              fontSize: 20,
              color: AppColor.color,
            ),
          )),
        ),
        //Центр диалога(Картинка)
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.network(
            widget.babyCard.image,
            fit: BoxFit.fill,
          ),
        ),
        //Низ диалога
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: AppColor.color2,
          ),
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Button play audio
              IconButton(
                iconSize: 30,
                color: AppColor.color,
                splashRadius: 20,
                onPressed: onPressedPlay,
                icon: const Icon(Icons.music_note),
              ),
              //Button play raw, если нету raw то пустота
              widget.babyCard.raw == null
                  ? Container()
                  : IconButton(
                      iconSize: 30,
                      color: AppColor.color,
                      splashRadius: 20,
                      onPressed: onPressedPlayRaw,
                      icon: const Icon(Icons.volume_up),
                    ),
              //Button close dialog
              IconButton(
                iconSize: 30,
                color: AppColor.color,
                splashRadius: 20,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
