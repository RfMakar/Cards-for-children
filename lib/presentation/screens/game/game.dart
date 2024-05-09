import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/game/game_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
    required this.categoryId,
  });
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => sl<GameStore>(param1: categoryId),
      child: const LayoutScreen(
        body: GameCards(),
        navigation: ButtomNavigation(),
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

class GameCards extends StatelessWidget {
  const GameCards({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GameStore>(context);
    return Observer(
      builder: (_) => store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: store.babyCardsRandom.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final babyCard = store.babyCardsRandom[index];
                    return BabyCardWidget(
                      babyCard: babyCard,
                      onTap: () async {
                        final isResult = store.onTapCardImage(babyCard);
                        if (isResult) {
                          await context.pushNamed(
                            'baby_card_screen',
                            extra: store.babyCardCorrect,
                          );
                          store.restartGame();
                        }
                      },
                    );
                  },
                ),
                const BabyCardCorrectWidget()
              ],
            ),
    );
  }
}

class BabyCardCorrectWidget extends StatelessWidget {
  const BabyCardCorrectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GameStore>(context);

    return Observer(
      builder: (_) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(store.babyCardCorrect.color),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            border: Border.all(
              color: AppColor.color2,
              width: 6,
            ),
          ),
          child: Image.asset(
            store.babyCardCorrect.icon,
            height: 180,
            width: 180,
          ),
        ),
      ),
    );
  }
}
