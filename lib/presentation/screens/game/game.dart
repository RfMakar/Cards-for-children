import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/game/game_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => sl<GameStore>(param1: categoryId),
      child: const LayoutScreen(
        body: BodyGameScreen(),
        navigation: ButtomNavigation(),
      ),
    );
  }
}

class BodyGameScreen extends StatefulWidget {
  const BodyGameScreen({super.key});

  @override
  State<BodyGameScreen> createState() => _BodyGameScreenState();
}

class _BodyGameScreenState extends State<BodyGameScreen> {
  late GameStore store;

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<GameStore>(context);
    return Observer(
      builder: (_) =>
          store.isLoading ? const LoadingWidget() : const BabyCardsList(),
    );
  }
}

class BabyCardsList extends StatelessWidget {
  const BabyCardsList({super.key});

  int crossAxisCount(double width) => width > 500 ? 3 : 2;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final store = Provider.of<GameStore>(context);
    return Observer(
      builder: (context) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount(width),
          childAspectRatio: 0.80,
        ),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
        itemCount: store.babyCardsRandom.length,
        itemBuilder: (context, index) {
          return BabyCardWidget(
            babyCard: store.babyCardsRandom[index],
            onTap: () async {
              final isResult = await store.onTapCardImage(
                store.babyCardsRandom[index],
              );

              if (isResult && context.mounted) {
                await context.pushNamed(
                  RouterPath.pathBabyCardScreen,
                  extra: store.babyCardCorrect,
                );
                store.restartGame();
              }
            },
          );
        },
      ),
    );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GameStore>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton.from(
              onTap: context.pop,
            ),
            AppButton.query(
              onTap: store.playQuestion,
            ),
            AppButton.reset(
              onTap: store.restartGame,
            ),
          ],
        ),
      ),
    );
  }
}
