import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/bloc/baby_cards_favorite_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BabyCardsFavoriteScreen extends StatelessWidget {
  const BabyCardsFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BabyCardsFavoriteBloc>()
        ..add(
          const BabyCardsFavoriteInitialization(),
        ),
      child: const LayoutScreen(
        body: BodyBabyCardsFavorite(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationFavoriteHome(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BodyBabyCardsFavorite extends StatelessWidget {
  const BodyBabyCardsFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabyCardsFavoriteBloc, BabyCardsFavoriteState>(
      builder: (context, state) {
        switch (state.status) {
          case BabyCardsFavoriteStatus.initial:
          case BabyCardsFavoriteStatus.loading:
            return const LoadingWidget();
          case BabyCardsFavoriteStatus.success:
            return state.babyCardsFavorite.isEmpty
                ? const BabyCardsFavoriteListIsEmpty()
                : BabyCardsFavoriteList(
                    babyCardsFavorite: state.babyCardsFavorite,
                  );
          case BabyCardsFavoriteStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class BabyCardsFavoriteListIsEmpty extends StatelessWidget {
  const BabyCardsFavoriteListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        height: 300,
        AppAssets.imageEmpty,
        fit: BoxFit.fill,
      ),
    );
  }
}

class BabyCardsFavoriteList extends StatelessWidget {
  const BabyCardsFavoriteList({super.key, required this.babyCardsFavorite});
  final List<BabyCard> babyCardsFavorite;

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
      itemCount: babyCardsFavorite.length,
      itemBuilder: (context, index) {
        return BabyCardWidget(
          babyCard: babyCardsFavorite[index],
          onTap: () => context.pushNamed(
            RouterPath.pathBabyCardScreen,
            extra: babyCardsFavorite[index],
          ),
        );
      },
    );
  }
}

class ButtonNavigationFavoriteHome extends StatelessWidget {
  const ButtonNavigationFavoriteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.home(
      onTap: context.pop,
    );
  }
}
