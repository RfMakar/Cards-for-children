import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_card/baby_card_store.dart';

import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BabyCardScreen extends StatelessWidget {
  const BabyCardScreen({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => sl<BabyCardStore>(
        param1: babyCard,
      ),
      child: Scaffold(
        backgroundColor: Color(babyCard.color).withOpacity(0.3),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopWidgetBabyCard(),
              ImageWidgetBabyCard(),
              BottomWidgetBabyCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopWidgetBabyCard extends StatelessWidget {
  const TopWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton.close(
            onTap: context.pop,
          ),
        ],
      ),
    );
  }
}

class ImageWidgetBabyCard extends StatelessWidget {
  const ImageWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final babyCard = context.read<BabyCardStore>().babyCard;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 4,
          color: AppColor.white,
        ),
      ),
      child: InkWell(
        onTap: context.pop,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            babyCard.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class BottomWidgetBabyCard extends StatelessWidget {
  const BottomWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<BabyCardStore>();
    final babyCard = store.babyCard;
    final isRaw = babyCard.raw != null;
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: isRaw
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton.raw(onTap: store.playRawBabyCard),
                  ButtonFavoriteBabyCard(),
                  AppButton.audio(onTap: store.playAudioBabyCard),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonFavoriteBabyCard(),
                  AppButton.audio(onTap: store.playAudioBabyCard),
                ],
              ));
  }
}

class ButtonFavoriteBabyCard extends StatelessWidget {
  const ButtonFavoriteBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<BabyCardStore>();
    return Observer(
      builder: (context) => store.isFavoriteBabyCards
          ? AppButton.favorite(
              onTap: store.updateFavoriteBabyCard,
            )
          : AppButton.notFavorite(
              onTap: store.updateFavoriteBabyCard,
            ),
    );
  }
}
