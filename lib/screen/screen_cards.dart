import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/dialog_image/dilog_image_card.dart';
import 'package:busycards/screen/game/screen_game.dart';
import 'package:busycards/screen/menu_category/menu_category_cards.dart';
import 'package:busycards/style_app.dart';
import 'package:flutter/material.dart';

class ScreenCards extends StatelessWidget {
  const ScreenCards({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const WidgetButtonStar(),
      //   backgroundColor: ColorsApp.color2,
      //   centerTitle: true,
      //   title: Text(
      //     'Карточки для детей',
      //     style: TextStyle(
      //       color: menu.colorCard(),
      //     ),
      //   ),
      // ),
      body: FutureBuilder<List<BabyCard>>(
        future: DBBabyCards.getListBabyCards(menu.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          final listBabyCards = snapshot.data!;
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              GridView.builder(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 66),
                  itemCount: listBabyCards.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 230,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CardImage(
                      babyCard: listBabyCards[index],
                      menu: menu,
                    );
                  }),
              ButtonNavigator(
                listBabyCard: listBabyCards,
                menu: menu,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ButtonNavigator extends StatelessWidget {
  const ButtonNavigator(
      {super.key, required this.listBabyCard, required this.menu});
  final List<BabyCard> listBabyCard;
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    final idTable = listBabyCard[0].name == 'Буква А';
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            backgroundColor: menu.colorCard(),
            heroTag: 2,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const MenuCategoryCards(),
              );
            },
            child: const Icon(Icons.grid_on),
          ),
          !idTable
              ? FloatingActionButton(
                  backgroundColor: menu.colorCard(),
                  heroTag: 1,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenGame(
                          listBabyCard: listBabyCard,
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.question_mark),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({Key? key, required this.babyCard, required this.menu})
      : super(key: key);
  final BabyCard babyCard;
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => DialogImageCard(babyCard: babyCard),
        );
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(babyCard.icon),
            ),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: menu.colorCard(),
              ),
              child: Center(
                child: Text(
                  babyCard.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    color: ColorsApp.color2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
