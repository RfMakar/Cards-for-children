import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/baby_cards_favorite_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
          ? const LoadingWidget()
          : const BabyCardsFvoriteList(),
    );
  }
}

class BabyCardsFvoriteList extends StatelessWidget {
  const BabyCardsFvoriteList({super.key});

  int crossAxisCount(double width) => width > 500 ? 3 : 2;

  @override
  Widget build(BuildContext context) {
     final width = MediaQuery.of(context).size.width;
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
        : GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount(width),
              childAspectRatio: 0.80,
            ),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
            itemCount: babyCardsFavorite.length,
            itemBuilder: (context, index) {
              return BabyCardWidget(
                babyCard: babyCardsFavorite[index],
                onTap: () => context.pushNamed(
                  RouterPath.pathBabyCardScreen,
                  extra: babyCardsFavorite[index],
                ),
              );
            },
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
