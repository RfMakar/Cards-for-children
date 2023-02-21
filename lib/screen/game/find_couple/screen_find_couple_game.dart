import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game/find_couple/provider_screen_find_couple_game.dart';
import 'package:busycards/screen/game/widget/widget_menu_category_cards.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFindCoupleGame extends StatelessWidget {
  const ScreenFindCoupleGame({Key? key, this.idTable = 0}) : super(key: key);
  final int idTable;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Найди пару', style: TextApp.appBar),
        backgroundColor: ColorsApp.menuGame,
      ),
      backgroundColor: ColorsApp.backgroundMenuGame,
      body: ListGame(idTable: idTable),
    );
  }
}

class ListGame extends StatelessWidget {
  const ListGame({Key? key, required this.idTable}) : super(key: key);
  final int idTable;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderScreenFindCoupleGame(idTable),
        child: Consumer<ProviderScreenFindCoupleGame>(
          builder: (_, model, __) {
            return FutureBuilder<Map<int, BabyCard>>(
                future: model.listCard,
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
                            Center(child: Text('2x2', style: TextApp.primary)),
                            Center(child: Text('2x3', style: TextApp.primary)),
                            Center(child: Text('3x4', style: TextApp.primary)),
                          ],
                        ),
                      ),
                      WidgetTable(listBabyCards: listBabyCards, model: model),
                      ButtonMenuCategoryGame(
                        onPressed: () async {
                          navigator(int id) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenFindCoupleGame(
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
  final Map<int, BabyCard> listBabyCards;
  final ProviderScreenFindCoupleGame model;

  @override
  Widget build(BuildContext context) {
    List<Widget> listTable;
    if (model.isSelectTable[0] == true) {
      listTable = [
        Row(children: [card(0), card(1)]),
        Row(children: [card(2), card(3)]),
      ];
    } else if (model.isSelectTable[1] == true) {
      listTable = [
        Row(children: [card(0), card(1)]),
        Row(children: [card(2), card(3)]),
        Row(children: [card(4), card(5)]),
      ];
    } else {
      listTable = [
        Row(children: [card(0), card(1), card(2)]),
        Row(children: [card(3), card(4), card(5)]),
        Row(children: [card(6), card(7), card(8)]),
        Row(children: [card(9), card(10), card(11)]),
      ];
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FittedBox(
            child: Column(
              children: listTable,
            ),
          ),
        ),
      ),
    );
  }

  Widget card(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
          color: model.colorCard[index],
          child: InkWell(
            onTap: model.pressedCard[index]
                ? () => model.onClick(index, listBabyCards[index]!)
                : null,
            child: Image.asset(listBabyCards[index]!.icon),
          )),
    );
  }
}
