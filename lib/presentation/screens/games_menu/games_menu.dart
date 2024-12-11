import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/games_menu/bloc/games_menu_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GamesMenuScreen extends StatelessWidget {
  const GamesMenuScreen({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GamesMenuBloc>()
            ..add(
              GamesMenuInitialization(categoryId),
            ),
        ),
        Provider(
          create: (context) => categoryId,
        ),
      ],
      child: const LayoutScreen(
        body: BodyGamesMenuScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonGameMenuFrom(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BodyGamesMenuScreen extends StatelessWidget {
  const BodyGamesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesMenuBloc, GamesMenuState>(
      builder: (context, state) {
        switch (state.status) {
          case GamesMenuStatus.initial:
          case GamesMenuStatus.loading:
            return const LoadingWidget();
          case GamesMenuStatus.success:
            return GamesMenu(babyCards: state.babyCards);
          case GamesMenuStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class GamesMenu extends StatelessWidget {
  const GamesMenu({super.key, required this.babyCards});
  final List<BabyCard> babyCards;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Center(
      child: orientation == Orientation.portrait ? _portrait() : _landscape(),
    );
  }

  Widget _portrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonGameShowMe(
          babyCards: babyCards,
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonGameFindAPair(
          babyCards: babyCards,
        ),
      ],
    );
  }

  Widget _landscape() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonGameShowMe(
          babyCards: babyCards,
        ),
        const SizedBox(
          width: 20,
        ),
        ButtonGameFindAPair(
          babyCards: babyCards,
        ),
      ],
    );
  }
}

class ButtonGameShowMe extends StatelessWidget {
  const ButtonGameShowMe({super.key, required this.babyCards});
  final List<BabyCard> babyCards;
  final double borderRadius = 25;
  final double borderWidth = 4;
  final double margin = 2;

  @override
  Widget build(BuildContext context) {
    final color = babyCards.first.color;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.pushNamed(
        RouterPath.pathGameShowMeScreen,
        extra: context.read<int>(),
      ),
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Color(color).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: GridView(
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
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          assets,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class ButtonGameFindAPair extends StatelessWidget {
  const ButtonGameFindAPair({super.key, required this.babyCards});
  final List<BabyCard> babyCards;
  final double borderRadius = 25;
  final double borderWidth = 4;
  final double margin = 2;
  @override
  Widget build(BuildContext context) {
    final color = babyCards.first.color;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.pushNamed(
        RouterPath.pathGameFindAPairScreen,
        extra: context.read<int>(),
      ),
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Color(color).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: GridView(
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
        padding: const EdgeInsets.all(12.0),
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
    return AppButton.from(
      onTap: context.pop,
    );
  }
}
