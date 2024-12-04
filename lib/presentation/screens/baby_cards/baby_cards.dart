import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards/bloc/baby_cards_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/failed.dart';
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
      child: LayoutScreen(
        body: BodyBabyCardsScreen(),
        navigation: ButtomNavigation(categoryId: categoryId),
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
            return LoadingWidget();
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

  int crossAxisCount(double width) => width > 500 ? 3 : 2;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount(width),
        childAspectRatio: 0.80,
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
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

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key, required this.categoryId});
  final int categoryId;
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
            AppButton.home(
              onTap: context.pop,
            ),
            AppButton.game(
              onTap: () => context.pushNamed(
                RouterPath.pathGamesMenuScreen,
                extra: categoryId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
