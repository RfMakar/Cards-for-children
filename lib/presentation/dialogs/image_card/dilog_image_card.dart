import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/presentation/dialogs/image_card/provider_dialog_image_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCardDialog extends StatelessWidget {
  const ImageCardDialog({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialoImageCard(babyCard),
      child: Builder(
        builder: (context) {
          var model = context.read<ProviderDialoImageCard>();
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
                  model.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.color,
                  ),
                )),
              ),
              //Центр диалога(Картинка)
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  model.image,
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
                      onPressed: model.onPressedPlay,
                      icon: const Icon(Icons.music_note),
                    ),
                    //Button play raw, если нету raw то пустота
                    model.raw == null
                        ? Container()
                        : IconButton(
                            iconSize: 30,
                            color: AppColor.color,
                            splashRadius: 20,
                            onPressed: model.onPressedPlayRaw,
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
        },
      ),
    );
  }
}
