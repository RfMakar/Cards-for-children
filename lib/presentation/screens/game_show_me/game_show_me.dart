import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/objects/game_show_me/game_show_me_card.dart';
import 'package:busycards/presentation/screens/game_show_me/bloc/game_show_me_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class GameShowMeScreen extends StatelessWidget {
  const GameShowMeScreen({super.key, required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GameShowMeBloc>()
        ..add(
          GameShowMeInitialization(
            categoryId,
          ),
        ),
      child: const LayoutScreen(
        body: BodyGameShowMeScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationGameShoweMeFrom(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BodyGameShowMeScreen extends StatelessWidget {
  const BodyGameShowMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameShowMeBloc, GameShowMeState>(
      listener: (context, state) async {
        if (state.status == GameShowMeStatus.congratulation) {
          final color = state.gameShowMe!.gameShowMeCards[0].color;
          await context.pushNamed(
            RouterPath.pathCongratulationScreen,
            extra: color,
          );
          if (context.mounted) {
            context.read<GameShowMeBloc>().add(const GameShowMeRestart());
          }
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case GameShowMeStatus.initial:
          case GameShowMeStatus.loading:
            return const LoadingWidget();
          case GameShowMeStatus.congratulation:
          case GameShowMeStatus.success:
            return GameCardsList(
              gameShowMeCards: state.gameShowMe!.gameShowMeCards,
            );
          case GameShowMeStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class GameCardsList extends StatelessWidget {
  const GameCardsList({super.key, required this.gameShowMeCards});
  final List<GameShowMeCard> gameShowMeCards;
  @override
  Widget build(BuildContext context) {
    final isHeight = MediaQuery.of(context).size.height > 1000;
    final orientation = MediaQuery.of(context).orientation;
    return Align(
      alignment: Alignment.center,
      child: GridView.builder(
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        padding: EdgeInsets.only(
          left: isHeight ? 100 : 8,
          right: isHeight ? 100 : 8,
          bottom: orientation == Orientation.portrait
              ? 80
              : isHeight
                  ? 100
                  : 8,
          top: orientation == Orientation.portrait
              ? 0
              : isHeight
                  ? 100
                  : 8,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gameShowMeCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ShowMeCard(
            gameShowMeCard: gameShowMeCards[index],
          );
        },
      ),
    );
  }
}

class ShowMeCard extends StatelessWidget {
  const ShowMeCard({super.key, required this.gameShowMeCard});
  final GameShowMeCard gameShowMeCard;

  Widget? childStack() {
    switch (gameShowMeCard.status) {
      case GameShowMeCardStatus.disabled:
      case GameShowMeCardStatus.enabled:
        return null;
      case GameShowMeCardStatus.right:
        return SvgPicture.asset(
          AppAssets.iconYes,
          height: 100,
          width: 100,
        );
      case GameShowMeCardStatus.wrong:
        return SvgPicture.asset(
          AppAssets.iconNo,
          height: 100,
          width: 100,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(gameShowMeCard.color),
          width: 2,
        ),
      ),
      child: RawMaterialButton(
        onPressed: null,
        child: InkWell(
          splashColor: Color(gameShowMeCard.color),
          borderRadius: BorderRadius.circular(23),
          onTap: gameShowMeCard.status == GameShowMeCardStatus.enabled
              ? () async {
                  context.read<GameShowMeBloc>().add(
                        GameShowMeOnTapCard(
                            gameShowMeCardId: gameShowMeCard.id),
                      );
                }
              : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                gameShowMeCard.icon,
                fit: BoxFit.fill,
              ),
              childStack() ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonNavigationGameShoweMeFrom extends StatelessWidget {
  const ButtonNavigationGameShoweMeFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.from(
      onTap: context.pop,
    );
  }
}
