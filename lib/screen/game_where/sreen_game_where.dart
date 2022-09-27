import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game_where/provider_card_image.dart';
import 'package:busycards/screen/game_where/provider_screen_game_where.dart';
import 'package:busycards/screen/widget/button_navigator_back.dart';

import 'package:busycards/screen/widget/button_navigator_cards.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenGameWhere extends StatelessWidget {
  const ScreenGameWhere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListBabyCards(),
    );
  }
}

class ListBabyCards extends StatelessWidget {
  const ListBabyCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderScreenGameWhere(),
        child: Consumer<ProviderScreenGameWhere>(
          builder: (_, model, __) {
            return FutureBuilder<List<BabyCard>>(
                future: model.list(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final listBabyCards = snapshot.data!;
                  return Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          shrinkWrap: true,
                          itemCount: listBabyCards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            var babyCardCorrect = model.babyCardCorrect;
                            return CardImage(
                              babyCard: listBabyCards[index],
                              babyCardCorrect: babyCardCorrect,
                              restartGame: model.restartGame,
                            );
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const ButtonNavigatorBack(),
                                ElevatedButton(
                                  style: StyleWidget.styleIconButton,
                                  onPressed: model.playQuestion,
                                  child: const Icon(Icons.music_note),
                                ),
                                const ButtonNavigatorCards(
                                    udatePage: ScreenGameWhere()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          },
        ));
  }
}

class CardImage extends StatelessWidget {
  const CardImage(
      {Key? key,
      required this.babyCard,
      required this.babyCardCorrect,
      required this.restartGame})
      : super(key: key);
  final BabyCard babyCard;
  final BabyCard babyCardCorrect;
  final Function restartGame;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderCardImage(babyCard, babyCardCorrect, restartGame),
      child: Consumer<ProviderCardImage>(
        builder: (_, model, __) => Card(
          child: InkWell(
            onTap: model.clickCardImage ? model.onTapCardImage : null,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(model.pathImage, fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }
}
