import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/cards/dilog_image_card.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';

class ScreenCards extends StatelessWidget {
  const ScreenCards({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name, style: TextApp.appBar),
        backgroundColor: ColorsApp.menuCards,
      ),
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
          return GridView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: listBabyCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return CardImage(babyCard: listBabyCards[index]);
              });
        },
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({Key? key, required this.babyCard}) : super(key: key);
  final BabyCard babyCard;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => DialogImageCard(babyCard: babyCard),
          );
        },
        child: Stack(
          children: [
            Image.asset(babyCard.icon),
            babyCard.raw == null
                ? Container()
                : Icon(
                    Icons.volume_up,
                    color: ColorsApp.menuCards,
                    size: 20,
                  ),
          ],
        ),
      ),
    );
  }
}
