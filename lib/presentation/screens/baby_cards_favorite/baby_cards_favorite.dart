import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_cards_favorite/bloc/baby_cards_favorite_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/baby_card_widget.dart';
import 'package:busycards/presentation/widgets/failed.dart';
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
          BabyCardsFavoriteInitialization(),
        ),
      child: const LayoutScreen(
        body: BodyBabyCardsFavorite(),
        navigation: ButtomNavigation(),
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
        if (state is BabyCardsFavoriteLoadInProgress) {
          return LoadingWidget();
        } else if (state is BabyCardsFavoriteLoadFailed) {
          return FailedWidget(message: state.message);
        } else if (state is BabyCardsFavoriteLoadSucces) {
          return state.babyCardsFavorite.isEmpty
              ? BabyCardsFavoriteListIsEmpty()
              : BabyCardsFavoriteList(
                  babyCardsFavorite: state.babyCardsFavorite,
                );
        }
        return Container();
      },
    );
  }
}

class BabyCardsFavoriteListIsEmpty extends StatelessWidget {
  const BabyCardsFavoriteListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            height: 200,
            AppAssets.imageEmpty,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

class BabyCardsFavoriteList extends StatelessWidget {
  const BabyCardsFavoriteList({super.key, required this.babyCardsFavorite});
  final List<BabyCard> babyCardsFavorite;
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

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

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
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
