import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/objects/game_find_a_pair/game_find_a_pair_card.dart';
import 'package:busycards/presentation/screens/game_find_a_pair/bloc/game_find_a_pair_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameFindAPairScreen extends StatelessWidget {
  const GameFindAPairScreen({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GameFindAPairBloc>()
        ..add(
          GameFindAPairInitialization(categoryId),
        ),
      child: const LayoutScreen(
        body: BodyGameFindAPair(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationGameFinfAPairFrom(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BodyGameFindAPair extends StatelessWidget {
  const BodyGameFindAPair({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameFindAPairBloc, GameFindAPairState>(
      listener: (context, state) async {
        if (state.status == GameFindAPairStatus.congratulation) {
          final color = state.babyCards[0].color;
          await context.pushNamed(
            RouterPath.pathCongratulationScreen,
            extra: color,
          );
          if (context.mounted) {
            context.read<GameFindAPairBloc>().add(const GameFindAPairRestartGame());
          }
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case GameFindAPairStatus.initial:
          case GameFindAPairStatus.loading:
            return const LoadingWidget();
          case GameFindAPairStatus.congratulation:
          case GameFindAPairStatus.success:
            return GameFindAPairCards(
              gameFindAPairCards: state.gameFindAPair!.gameFindAPairCards,
            );
          case GameFindAPairStatus.failure:
            return FailedWidget(
              message: state.error!,
            );
        }
      },
    );
  }
}

class GameFindAPairCards extends StatelessWidget {
  const GameFindAPairCards({super.key, required this.gameFindAPairCards});
  final List<GameFindAPairCard> gameFindAPairCards;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Align(
      alignment: Alignment.center,
      child: GridView.builder(
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: orientation == Orientation.portrait ? 80 : 8,
          top: orientation == Orientation.portrait ? 0 : 8,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gameFindAPairCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return FindAPairCard(
            gameCard: gameFindAPairCards[index],
          );
        },
      ),
    );
  }
}

class FindAPairCard extends StatelessWidget {
  const FindAPairCard({super.key, required this.gameCard});
  final GameFindAPairCard gameCard;

  Color _colorCard() {
    switch (gameCard.status) {
      case GameFindAPairCardStatus.enabled:
        return AppColor.white.withOpacity(0.8);
      case GameFindAPairCardStatus.select:
        return Color(gameCard.color);
      case GameFindAPairCardStatus.right:
        return AppColor.right;
      case GameFindAPairCardStatus.wrong:
        return AppColor.wrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: _colorCard(),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: gameCard.status == GameFindAPairCardStatus.enabled
            ? () async {
                context.read<GameFindAPairBloc>().add(
                      GameFindAPairOnTap(
                        gameFindAPairId: gameCard.id,
                      ),
                    );
              }
            : null,
        child: Image.asset(
          gameCard.icon,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ButtonNavigationGameFinfAPairFrom extends StatelessWidget {
  const ButtonNavigationGameFinfAPairFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.from(
      onTap: context.pop,
    );
  }
}
