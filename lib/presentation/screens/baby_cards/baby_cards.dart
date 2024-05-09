import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
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
        body: BabyCardsList(),
        navigation: ButtomNavigation(),
      ),
    );
    
  }
}

class BabyCardsList extends StatelessWidget {
  const BabyCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<BabyCardsStore>(context);
    return Observer(
      builder: (_) => store.isLoading
          ? const CircularProgressIndicator()
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: store.babyCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final babyCard = store.babyCards[index];
                return BabyCardWidget(
                  babyCard: babyCard,
                  onTap: () => context.pushNamed(
                    'baby_card_screen',
                    extra: babyCard,
                  ),
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
    final store = Provider.of<BabyCardsStore>(context);
    // final store = Provider.of<BabyCardsStore>(context);
    // final isAlphabet = store.babyCards.first.name == 'Буква А';
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
                'game_screen',
                extra: store.categoryId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
