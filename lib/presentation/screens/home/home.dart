import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/presentation/screens/home/bloc/home_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayerService _audioPlayerService;

  @override
  void initState() {
    _audioPlayerService = sl<AudioPlayerService>();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  void _initLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    Intl.defaultLocale = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    _initLocale(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>()..add(const HomeInitialization()),
        ),
        Provider(
          create: (context) => _audioPlayerService,
        ),
      ],
      child: const LayoutScreen(
        body: BodyHomeScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationHomeFavorite(),
            ButtonNavigationHomeSettings(),
          ],
        ),
      ),
    );
  }
}

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initial:
          case HomeStatus.loading:
            return const LoadingWidget();
          case HomeStatus.success:
            return CategoryCardsList(
              categorysCards: state.categorysCards,
            );
          case HomeStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class CategoryCardsList extends StatelessWidget {
  const CategoryCardsList({super.key, required this.categorysCards});
  final List<CategoryCard> categorysCards;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final audioPlayerService = context.read<AudioPlayerService>();
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
      itemCount: categorysCards.length,
      itemBuilder: (context, index) {
        final categoryCard = categorysCards[index];
        return CategoryCardWidget(
          categoryCard: categoryCard,
          onTap: () {
            audioPlayerService.play(categoryCard.audio);
            context.pushNamed(
              RouterPath.pathBabyCardsScreen,
              extra: categoryCard.id,
            );
          },
        );
      },
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.categoryCard,
    required this.onTap,
  });

  final CategoryCard categoryCard;
  final Function() onTap;
  final radius = 12.0;
  final borderWidht = 2.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(categoryCard.color),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: AppColor.white,
            width: borderWidht,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  categoryCard.icon,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius - borderWidht),
                  bottomRight: Radius.circular(radius - borderWidht),
                ),
                border: Border.all(
                  color: AppColor.white,
                ),
                color: AppColor.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  categoryCard.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    color: Color(categoryCard.color),
                    //fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonNavigationHomeFavorite extends StatelessWidget {
  const ButtonNavigationHomeFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.notFavorite(
      onTap: () => context.pushNamed(
        RouterPath.pathFavoriteBabyCardsScreen,
      ),
    );
  }
}

class ButtonNavigationHomeSettings extends StatelessWidget {
  const ButtonNavigationHomeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.settings(
      onTap: () => context.pushNamed(
        RouterPath.pathParentalControlScreen,
      ),
    );
  }
}
