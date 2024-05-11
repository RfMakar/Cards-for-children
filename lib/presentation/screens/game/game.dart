import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/game/game_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

class BodyGameScreen extends StatelessWidget {
  const BodyGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GameStore>(context);
    return Observer(
      builder: (_) => store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : const  BabyCardsList(),
    );
  }
}

class BabyCardsList extends StatelessWidget {
  const BabyCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GameStore>(context);
    return Observer(
      builder: (_) => AnimationLimiter(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          children: List.generate(
            store.babyCardsRandom.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: BabyCardWidget(
                      babyCard: store.babyCardsRandom[index],
                      onTap: () async {
                        final isResult = store.onTapCardImage(
                          store.babyCardsRandom[index],
                        );
                        if (isResult) {
                          await context.pushNamed(
                            'baby_card_screen',
                            extra: store.babyCardCorrect,
                          );
                          store.restartGame();
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
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
              Radius.circular(50),
            ),
            border: Border.all(
              color: AppColor.white,
              width: 3,
            ),
          ),
          child: Image.asset(
            store.babyCardCorrect.icon,
            height: 150,
            width: 150,
          ),
        ),
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
