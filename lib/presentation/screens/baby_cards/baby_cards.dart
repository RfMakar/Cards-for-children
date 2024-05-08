import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/baby_cards/baby_cards_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/cloud.dart';
import 'package:busycards/presentation/widgets/grass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BabyCardsScreen extends StatelessWidget {
  const BabyCardsScreen({super.key, required this.idCategory});
  final int idCategory;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => sl<BabyCardsStore>(param1: idCategory),
      child: const Scaffold(
        backgroundColor: AppColor.color3,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              CloudWidget(),
              BabyCardsList(),
              GrassWidget(),
              ButtomNavigation(),
            ],
          ),
        ),
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
                final babyCards = store.babyCards[index];
                return BabyCardWidget(babyCard: babyCards);
              },
            ),
    );
  }
}

class BabyCardWidget extends StatelessWidget {
  const BabyCardWidget({
    super.key,
    required this.babyCard,
  });
  final BabyCard babyCard;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('baby_card_screen', extra: babyCard),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.color2,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: Color(babyCard.color),
            width: 3,
          ),
        ),
        child: Center(
          child: Image.asset(babyCard.icon),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Image.asset(babyCard.icon),
        //     Container(
        //       height: 50,
        //       decoration: BoxDecoration(
        //         borderRadius: const BorderRadius.only(
        //           bottomLeft: Radius.circular(10),
        //           bottomRight: Radius.circular(10),
        //         ),
        //         color: Color(babyCard.color),
        //       ),
        //       child: Center(
        //         child: Text(
        //           babyCard.name,
        //           textAlign: TextAlign.center,
        //           maxLines: 2,
        //           softWrap: true,
        //           style: const TextStyle(
        //               color: AppColor.color2,
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
