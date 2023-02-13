import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game/quiz/provider_card_image.dart';
import 'package:busycards/screen/game/quiz/provider_screen_quiz_game.dart';
import 'package:busycards/screen/game/widget/widget_menu_category_cards.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenQuizGame extends StatelessWidget {
  const ScreenQuizGame({Key? key, this.idTable = 0}) : super(key: key);
  ScreenQuizGame newScreen(int idTable) => ScreenQuizGame(idTable: idTable);
  final int idTable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Викторина', style: TextApp.appBar),
        backgroundColor: ColorsApp.menuGame,
      ),
      backgroundColor: ColorsApp.backgroundMenuGame,
      body: ListGame(
        idTable: idTable,
      ),
    );
  }
}

class ListGame extends StatelessWidget {
  const ListGame({Key? key, required this.idTable}) : super(key: key);
  final int idTable;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderScreenQuizGame(),
        child: Consumer<ProviderScreenQuizGame>(
          builder: (_, model, __) {
            return FutureBuilder<List<BabyCard>>(
                future: model.list(idTable),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final listBabyCards = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ToggleButtons(
                          onPressed: (index) =>
                              model.onPressedToggleButtons(index),
                          isSelected: model.isSelectTable,
                          children: [
                            Center(child: Text('1x2', style: TextApp.primary)),
                            Center(child: Text('2x2', style: TextApp.primary)),
                            Center(child: Text('3x2', style: TextApp.primary)),
                          ],
                        ),
                      ),
                      WidgetTable(listBabyCards: listBabyCards, model: model),
                      ButtonMenuCategoryGame(
                        onPressed: () async {
                          navigator(int id) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenQuizGame(
                                    idTable: id,
                                  ),
                                ),
                              );
                          int? idTable = await showModalBottomSheet(
                            context: context,
                            builder: (context) => const ListCategoryGame(),
                          );
                          if (idTable != null) {
                            navigator(idTable);
                          }
                        },
                      ),
                    ],
                  );
                });
          },
        ));
  }
}

class WidgetTable extends StatelessWidget {
  const WidgetTable(
      {Key? key, required this.listBabyCards, required this.model})
      : super(key: key);

  final List<BabyCard> listBabyCards;
  final ProviderScreenQuizGame model;
  @override
  Widget build(BuildContext context) {
    if (model.isSelectTable[0] == true) {
      return table1x1();
    } else if (model.isSelectTable[1] == true) {
      return table2x2();
    } else {
      return table3x2();
    }
  }

  Widget table1x1() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FittedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    CardImage(
                      babyCard: listBabyCards[0],
                      babyCardCorrect: model.babyCardCorrect,
                      restartGame: model.restartGame,
                    ),
                    CardImage(
                      babyCard: listBabyCards[1],
                      babyCardCorrect: model.babyCardCorrect,
                      restartGame: model.restartGame,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget table2x2() {
    return Expanded(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CardImage(
                    babyCard: listBabyCards[0],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                  CardImage(
                    babyCard: listBabyCards[1],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                ],
              ),
              Row(
                children: [
                  CardImage(
                    babyCard: listBabyCards[2],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                  CardImage(
                    babyCard: listBabyCards[3],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget table3x2() {
    return Expanded(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CardImage(
                    babyCard: listBabyCards[0],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                  CardImage(
                    babyCard: listBabyCards[1],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                ],
              ),
              Row(
                children: [
                  CardImage(
                    babyCard: listBabyCards[2],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                  CardImage(
                    babyCard: listBabyCards[3],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                ],
              ),
              Row(
                children: [
                  CardImage(
                    babyCard: listBabyCards[4],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                  CardImage(
                    babyCard: listBabyCards[5],
                    babyCardCorrect: model.babyCardCorrect,
                    restartGame: model.restartGame,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
          color: ColorsApp.menuGame,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 3,
              color: ColorsApp.secondary,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: InkWell(
            onTap: model.clickCardImage ? model.onTapCardImage : null,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    Image.asset(model.pathImage, fit: BoxFit.fill),
                    Builder(builder: (context) {
                      if (!model.clickCardImage) {
                        return Image.asset(model.pathImageStack,
                            fit: BoxFit.fill);
                      } else {
                        return Container();
                      }
                    }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
