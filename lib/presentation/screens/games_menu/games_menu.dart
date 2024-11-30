import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/games_menu/bloc/games_menu_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
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
      child: LayoutScreen(
        body: BodyGamesMenuScreen(),
        navigation: ButtomNavigationGameMenuScreen(),
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
        if (state is GamesMenuLoadInProgress) {
          return LoadingWidget();
        } else if (state is GamesMenuLoadFailed) {
          return FailedWidget(message: state.message);
        } else if (state is GamesMenuLoadSucces) {
          return GamesMenu(babyCards: state.babyCards);
        }
        return Container();
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
    final width = MediaQuery.of(context).size.width;
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount(width),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
      children: [
        ButtonGameShowMe(babyCards: babyCards),
        // ButtonGameShowMe(),
        // ButtonGameShowMe(),
      ],
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

class ButtomNavigationGameMenuScreen extends StatelessWidget {
  const ButtomNavigationGameMenuScreen({super.key});

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
            AppButton.from(
              onTap: context.pop,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
