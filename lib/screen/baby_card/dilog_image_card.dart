import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/baby_card/provider_dialog_image_card.dart';
import 'package:busycards/screen/widget/style_app.dart';
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
            backgroundColor: Colors.white.withOpacity(0),
            children: [
              //Вверх диалога (Имя карточки)
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Color.fromRGBO(82, 182, 255, 1),
                ),
                height: 40,
                child: Center(
                    child: Text(model.name, style: StyleWidget.textStyleMenu)),
              ),
              //Центр диалога(Картинка)
              InkWell(
                onTap: () => Navigator.pop(context),
                child: ClipRRect(
                  child: Image.asset(
                    model.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //Низ диалога
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Color.fromRGBO(82, 182, 255, 0.8),
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Button play audio
                    IconButton(
                      iconSize: 35,
                      color: Colors.white,
                      splashRadius: 25,
                      onPressed: model.onPressedPlay,
                      icon: const Icon(Icons.music_note),
                    ),
                    //Button play raw, если нету raw то пустота
                    model.raw == null
                        ? Container()
                        : IconButton(
                            iconSize: 35,
                            color: Colors.white,
                            splashRadius: 25,
                            onPressed: model.onPressedPlayRaw,
                            icon: const Icon(Icons.volume_up),
                          ),
                    //Button close dialog
                    IconButton(
                      iconSize: 35,
                      color: Colors.white,
                      splashRadius: 25,
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
