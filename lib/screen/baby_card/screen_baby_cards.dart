import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/baby_card/dilog_image_card.dart';
import 'package:busycards/widget/button_navigator_cards.dart';
import 'package:busycards/widget/button_navigator_game.dart';
import 'package:busycards/widget/button_navigator_setting.dart';
import 'package:flutter/material.dart';

class ScreenBabyCards extends StatelessWidget {
  const ScreenBabyCards({Key? key}) : super(key: key);

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
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        FutureBuilder<List<BabyCard>>(
            future: DBBabyCards.getListCards(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              final listBabyCards = snapshot.data!;
              return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 75),
                  itemCount: listBabyCards.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //mainAxisExtent: 190,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return CardImage(babyCard: listBabyCards[index]);
                  });
            }),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              ButtonNavigatorGame(),
              ButtonNavigatorCards(updatePage: ScreenBabyCards()),
              ButtonNavigatorSetting(),
            ],
          ),
        ),
      ],
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.asset(babyCard.iconbutton),
        ),
      ),
    );
  }
}
