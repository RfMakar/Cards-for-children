import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/games_menu/games_menu_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GamesMenuScreen extends StatelessWidget {
  const GamesMenuScreen({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => sl<GamesMenuStore>(param1: categoryId),
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
    final store = Provider.of<GamesMenuStore>(context);
    return Observer(
      builder: (_) =>
          store.isLoading ? const LoadingWidget() : const GamesMenu(),
    );
  }
}

class GamesMenu extends StatelessWidget {
  const GamesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
      children: [
        ButtonGameShowMe(),
        ButtonGameShowMe(),
        ButtonGameShowMe(),
      ],
    );
  }
}

class ButtonGameShowMe extends StatelessWidget {
  const ButtonGameShowMe({super.key});
  final double borderRadius = 32;
  final double margin = 4;
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GamesMenuStore>(context);
    final color = store.babyCards.first.color;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.pushNamed(
        RouterPath.pathGameShowMeScreen,
        extra: store.categoryId,
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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(color),
                  ),
                ),
                Text(
                  '?',
                  style: TextStyle(
                    fontSize: 34,
                    color: AppColor.white,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(color),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  store.babyCards[0].icon,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(color),
              ),
              child: Image.asset(
                store.babyCards[1].icon,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(color),
              ),
              child: Image.asset(
                store.babyCards[2].icon,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
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
