import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/baby_cards_favorite_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BabyCardsFavoriteScreen extends StatelessWidget {
  const BabyCardsFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => sl<BabyCardsFavoriteStore>(),
      child: const LayoutScreen(
        body: BodyBabyCardsFavorite(),
        navigation: ButtomNavigation(),
      ),
    );
  }
}

class BodyBabyCardsFavorite extends StatelessWidget {
  const BodyBabyCardsFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<BabyCardsFavoriteStore>(context);
    return Observer(
      builder: (_) => store.isLoading
          ? const CircularProgressIndicator()
          : const BabyCardsFvoriteList(),
    );
  }
}

class BabyCardsFvoriteList extends StatelessWidget {
  const BabyCardsFvoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final babyCardsFavorite =
        Provider.of<BabyCardsFavoriteStore>(context).babyCardsFavorite;

    return babyCardsFavorite.isEmpty
        ? Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  height: 200,
                  AppAssets.imageEmpty,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        : AnimationLimiter(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
              childAspectRatio: 0.80,
              crossAxisCount: 2,
              children: List.generate(
                babyCardsFavorite.length,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: BabyCardWidget(
                          babyCard: babyCardsFavorite[index],
                          onTap: () => context.pushNamed(
                            'baby_card',
                            extra: babyCardsFavorite[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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
            AppButton.home(
              onTap: context.pop,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
