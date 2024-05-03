import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/data/data_sources/local/db_baby_cards.dart';
import 'package:busycards/data/model/menu.dart';
import 'package:busycards/presentation/widgets/button_star.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../screens/home/home.dart';

class CategoryCardsSheet extends StatelessWidget {
  const CategoryCardsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<Menu>>(
          future: DBBabyCards.getListMenuCards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final listMenuCards = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(8, 58, 8, 8),
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: AppColor.color2,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WidgetButtonStar(),
              const Text(
                'Категории',
                style: TextStyle(
                  color: AppColor.color,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: AppColor.color,
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
  const WidgetMenuCard({super.key, required this.menu});
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
              builder: (BuildContext context) => HomeScreen(menu: menu),
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
                  style: const TextStyle(fontSize: 10, color: AppColor.color2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
