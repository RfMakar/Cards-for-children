import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GamesMenuScreen extends StatelessWidget {
  const GamesMenuScreen({super.key, required this.babyCards});
  final List<BabyCard> babyCards;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => babyCards,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: const Stack(
          children: [
            GamesMenu(),
            ButtonGameMenuFrom(),
          ],
        ),
      ),
    );
  }
}

class GamesMenu extends StatelessWidget {
  const GamesMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Align(
      alignment: Alignment.center,
      child: orientation == Orientation.portrait ? _portrait() : _landscape(),
    );
  }

  Widget _portrait() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonGameShowMe(),
        SizedBox(height: 20),
        ButtonGameFindAPair(),
      ],
    );
  }

  Widget _landscape() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonGameShowMe(),
        SizedBox(width: 20),
        ButtonGameFindAPair(),
      ],
    );
  }
}

class ButtonGameShowMe extends StatelessWidget {
  const ButtonGameShowMe({super.key});

  final double borderRadius = 25;
  final double borderWidth = 4;
  final double margin = 6;

  @override
  Widget build(BuildContext context) {
    final babyCards = context.read<List<BabyCard>>();
    final color = babyCards.first.color;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.pushNamed(
        RouterPath.pathGameShowMeScreen,
        extra: babyCards
      ),
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Color(color),
            width: 2,
          ),
        ),
        child: GridView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _card(
              color: AppColor.wrong,
              assets: babyCards[2].icon,
            ),
            _card(
              color: Color(color),
              assets: babyCards[0].icon,
            ),
            _card(
              color: Color(color),
              assets: babyCards[1].icon,
            ),
            _card(
              color: Color(color),
              assets: babyCards[2].icon,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Color color, required String assets}) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          assets,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class ButtonGameFindAPair extends StatelessWidget {
  const ButtonGameFindAPair({super.key});
  final double borderRadius = 25;
  final double borderWidth = 4;
  final double margin = 6;
  @override
  Widget build(BuildContext context) {
    final babyCards = context.read<List<BabyCard>>();
    final color = babyCards.first.color;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.pushNamed(
        RouterPath.pathGameFindAPairScreen,
        extra: babyCards,
      ),
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Color(color),
              width: 2,
            )),
        child: GridView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _card(
              color: AppColor.right,
              assets: babyCards[2].icon,
            ),
            _card(
              color: AppColor.wrong,
              assets: babyCards[1].icon,
            ),
            _card(
              color: AppColor.right,
              assets: babyCards[2].icon,
            ),
            _card(
              color: AppColor.wrong,
              assets: babyCards[3].icon,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Color color, required String assets}) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          assets,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class ButtonGameMenuFrom extends StatelessWidget {
  const ButtonGameMenuFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Align(
      alignment: orientation == Orientation.portrait
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton.from(
          onTap: context.pop,
        ),
      ),
    );
  }
}
