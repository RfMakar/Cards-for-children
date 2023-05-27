import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/dialog_image/provider_dialog_image_card.dart';
import 'package:busycards/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogImageCard extends StatelessWidget {
  const DialogImageCard({Key? key, required this.babyCard}) : super(key: key);
  final BabyCard babyCard;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialoImageCard(babyCard),
      child: Builder(
        builder: (context) {
          var model = context.read<ProviderDialoImageCard>();
          return SimpleDialog(
            backgroundColor: ColorsApp.transparent,
            children: [
              //Вверх диалога (Имя карточки)
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: ColorsApp.color2),
                height: 40,
                child: Center(
                    child: Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorsApp.color,
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: ColorsApp.color2,
                ),
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Button play audio
                    IconButton(
                      iconSize: 30,
                      color: ColorsApp.color,
                      splashRadius: 20,
                      onPressed: model.onPressedPlay,
                      icon: const Icon(Icons.music_note),
                    ),
                    //Button play raw, если нету raw то пустота
                    model.raw == null
                        ? Container()
                        : IconButton(
                            iconSize: 30,
                            color: ColorsApp.color,
                            splashRadius: 20,
                            onPressed: model.onPressedPlayRaw,
                            icon: const Icon(Icons.volume_up),
                          ),
                    //Button close dialog
                    IconButton(
                      iconSize: 30,
                      color: ColorsApp.color,
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
