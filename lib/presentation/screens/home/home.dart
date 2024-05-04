import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/data/data_sources/local/db_baby_cards.dart';
import 'package:busycards/data/model/baby_card.dart';
import 'package:busycards/data/model/menu.dart';
import 'package:busycards/presentation/dialogs/image_card/dilog_image_card.dart';
import 'package:busycards/presentation/screens/game/screen_game.dart';
import 'package:busycards/presentation/sheets/category_cards.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.idCategory});
  final int idCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<List<BabyCard>>(
          future: DBBabyCards.getListBabyCards(idCategory),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 230,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return CardImage(
                        babyCard: listBabyCards[index],
                        //menu: menu,
                      );
                    }),
                ButtonNavigator(
                  listBabyCard: listBabyCards,
                  //menu: menu,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ButtonNavigator extends StatelessWidget {
  const ButtonNavigator(
      {super.key, required this.listBabyCard});
  final List<BabyCard> listBabyCard;
  //final Menu menu;
  @override
  Widget build(BuildContext context) {
    final idTable = listBabyCard[0].name == 'Буква А';
   // final backgroundColor = menu.colorCard().withOpacity(0.7);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
           // backgroundColor: backgroundColor,
            heroTag: 2,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const CategoryCardsSheet(),
              );
            },
            child: const Icon(
              Icons.grid_on,
              color: AppColor.color2,
            ),
          ),
          !idTable
              ? FloatingActionButton(
                  //backgroundColor: backgroundColor,
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
                  child: const Icon(
                    Icons.question_mark,
                    color: AppColor.color2,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.babyCard, });
  final BabyCard babyCard;
 // final Menu menu;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ImageCardDialog(babyCard: babyCard),
        );
      },
      child: Card(
        //shadowColor: menu.colorCard(),
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
               // color: menu.colorCard(),
              ),
              child: Center(
                child: Text(
                  babyCard.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    color: AppColor.color2,
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
