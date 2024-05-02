import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game/provider_screen_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenGame extends StatelessWidget {
  const ScreenGame({super.key, required this.listBabyCard});
  final List<BabyCard> listBabyCard;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenGame(listBabyCard),
      builder: (context, child) {
        return const Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(),
              GameCard(),
              ButtonNavigator(),
            ],
          ),
        );
      },
    );
  }
}

class WidgetText extends StatelessWidget {
  const WidgetText({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenGame>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        provider.babyCardCorrect.name,
        style: const TextStyle(
          fontSize: 24,
          color: AppColor.color,
        ),
      ),
    );
  }
}

class ButtonNavigator extends StatelessWidget {
  const ButtonNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.navigate_before),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        children: const [
          TableRow(
            children: [
              CardImage(index: 0),
              CardImage(index: 1),
            ],
          ),
          TableRow(
            children: [
              CardImage(index: 2),
              CardImage(index: 3),
            ],
          ),
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenGame>(context);
    return Card(
      child: InkWell(
        onTap: provider.clickCardImage[index]
            ? () => provider.onTapCardImage(index)
            : null,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                Image.asset(
                  provider.listStar[index].image,
                  fit: BoxFit.fill,
                ),
                Builder(builder: (context) {
                  if (!provider.clickCardImage[index]) {
                    return Image.asset(
                      provider.pathImageStack[index],
                      fit: BoxFit.fill,
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            )),
      ),
    );
  }
}
