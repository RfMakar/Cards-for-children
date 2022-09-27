import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/baby_card/provider_dialog_image_card.dart';
import 'package:busycards/screen/widget/style_widget.dart';
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
              Text(
                model.name,
                textAlign: TextAlign.center,
                style: StyleWidget.textStyle,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    model.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Divider(color: Color.fromRGBO(88, 213, 243, 0.8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: StyleWidget.styleIconButton,
                    onPressed: model.onPressedPlay,
                    child: const Icon(Icons.music_note),
                  ),
                  buttonRaw(model),
                  ElevatedButton(
                    style: StyleWidget.styleIconButton,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buttonRaw(ProviderDialoImageCard model) {
    return model.raw == null
        ? Container()
        : ElevatedButton(
            style: StyleWidget.styleIconButton,
            onPressed: model.onPressedPlayRaw,
            child: const Icon(Icons.volume_up),
          );
  }
}
