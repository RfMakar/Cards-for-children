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
            return LoadingWidget();
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
  int crossAxisCount(double width) => width > 500 ? 3 : 2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonGameShowMe(
        babyCards: babyCards,
      ),
    );
  }
}

class ButtonGameShowMe extends StatelessWidget {
  const ButtonGameShowMe({super.key, required this.babyCards});
  final List<BabyCard> babyCards;
  final double borderRadius = 32;
  final double margin = 4;
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
        height: 200,
        width: 200,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.6),
          border: Border.all(
            color: Color(color),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          physics: NeverScrollableScrollPhysics(),
          children: [
            _card(
              color: AppColor.colorSecondary,
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
        shape: BoxShape.circle,
        color: color,
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
