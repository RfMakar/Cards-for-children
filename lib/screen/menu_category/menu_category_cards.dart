import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/widget/button_star.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../style_app.dart';
import '../screen_cards.dart';

class MenuCategoryCards extends StatelessWidget {
  const MenuCategoryCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<Menu>>(
          future: DBBabyCards.getListMenuCards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            final listMenuCards = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(4, 50, 4, 4),
              shrinkWrap: true,
              itemCount: listMenuCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 150,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return WidgetMenuCard(
                  menu: listMenuCards[index],
                );
              },
            );
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: ColorsApp.color2.withOpacity(0.9),
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WidgetButtonStar(),
              Text(
                'Категории',
                style: TextStyle(
                  color: ColorsApp.color,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: ColorsApp.color,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WidgetMenuCard extends StatelessWidget {
  const WidgetMenuCard({Key? key, required this.menu}) : super(key: key);
  final Menu menu;

  void playCard() {
    final audioPlayer = AudioPlayer();
    audioPlayer.setAsset(menu.audio);
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        playCard();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ScreenCards(menu: menu),
            ),
            (route) => false);
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(menu.icon),
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
                  menu.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 10, color: ColorsApp.color2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
