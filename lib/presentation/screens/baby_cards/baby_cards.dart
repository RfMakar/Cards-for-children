import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BabyCardsScreen extends StatelessWidget {
  const BabyCardsScreen({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => sl<BabyCardsStore>(param1: categoryId),
      child: const LayoutScreen(
        body: BodyBabyCardsScreen(),
        navigation: ButtomNavigation(),
      ),
    );
  }
}

class BodyBabyCardsScreen extends StatelessWidget {
  const BodyBabyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<BabyCardsStore>(context);
    return Observer(
      builder: (_) => store.isLoading
          ? const LoadingWidget()
          : const BabyCardsList(),
    );
  }
}

class BabyCardsList extends StatelessWidget {
  const BabyCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<BabyCardsStore>(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.80,
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
      itemCount: store.babyCards.length,
      itemBuilder: (context, index) {
        return BabyCardWidget(
          babyCard: store.babyCards[index],
          onTap: () => context.pushNamed(
            RouterPath.pathBabyCardScreen,
            extra: store.babyCards[index],
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
    final store = Provider.of<BabyCardsStore>(context);
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
            AppButton.game(
              onTap: () => context.pushNamed(
                RouterPath.pathGamesMenuScreen,
                extra: store.categoryId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
