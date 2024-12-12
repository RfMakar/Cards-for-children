import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards/bloc/baby_cards_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BabyCardsScreen extends StatelessWidget {
  const BabyCardsScreen({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BabyCardsBloc>()
        ..add(
          BabyCardsInitialization(categoryId),
        ),
      child: const LayoutScreen(
        body: BodyBabyCardsScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            BottonNavigationBabyCardsHome(),
            BottonNavigatiombabyCardsGame(),
          ],
        ),
      ),
    );
  }
}

class BodyBabyCardsScreen extends StatelessWidget {
  const BodyBabyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabyCardsBloc, BabyCardsState>(
      builder: (context, state) {
        switch (state.status) {
          case BabyCardStatus.initial:
          case BabyCardStatus.loading:
            return const LoadingWidget();
          case BabyCardStatus.success:
            return BabyCardsList(babyCards: state.babyCards);
          case BabyCardStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class BabyCardsList extends StatelessWidget {
  const BabyCardsList({super.key, required this.babyCards});
  final List<BabyCard> babyCards;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;

    return GridView.builder(
      scrollDirection:
          orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: height > 1000 ? 3 : 2,
        childAspectRatio: orientation == Orientation.portrait ? 0.80 : 1.2,
      ),
      padding: orientation == Orientation.portrait
          ? const EdgeInsets.fromLTRB(8, 8, 8, 80)
          : const EdgeInsets.fromLTRB(32, 8, 80, 8),
      itemCount: babyCards.length,
      itemBuilder: (context, index) {
        return BabyCardWidget(
          babyCard: babyCards[index],
          onTap: () => context.pushNamed(
            RouterPath.pathBabyCardScreen,
            extra: babyCards[index],
          ),
        );
      },
    );
  }
}

class BottonNavigationBabyCardsHome extends StatelessWidget {
  const BottonNavigationBabyCardsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.home(
      onTap: context.pop,
    );
  }
}

class BottonNavigatiombabyCardsGame extends StatelessWidget {
  const BottonNavigatiombabyCardsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.game(onTap: () {
      final status = context.read<BabyCardsBloc>().state.status;
      if (status == BabyCardStatus.success) {
        context.pushNamed(
          RouterPath.pathGamesMenuScreen,
          extra: context.read<BabyCardsBloc>().state.babyCards,
        );
      }
    });
  }
}
