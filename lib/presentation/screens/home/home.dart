import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _initLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    Intl.defaultLocale = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    _initLocale(context);
    return const LayoutScreen(
      body: BodyHomeScreen(),
      navigation: ButtomNavigation(),
    );
  }
}

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return Observer(
      builder: (_) => store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : const CategoryCardsList(),
    );
  }
}

class CategoryCardsList extends StatelessWidget {
  const CategoryCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return AnimationLimiter(
      child: GridView.count(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
        //mainAxisSpacing: 1,
        childAspectRatio: 0.80,
        crossAxisCount: 2,
        children: List.generate(
          store.categorysCards.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: CategoryCardWidget(
                    categoryCard: store.categorysCards[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.categoryCard,
  });

  final CategoryCard categoryCard;
  final radius = 12.0;
  final borderWidht = 2.0;

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () {
        store.playAudio(categoryCard);

        context.pushNamed(
          'baby_cards',
          extra: categoryCard.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color(categoryCard.color),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(
            color: AppColor.white,
            width: borderWidht,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(categoryCard.icon),
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
            AppButton.notFavorite(
              onTap: () => context.pushNamed('favorite_baby_cards'),
            ),
            AppButton.settings(
              onTap: () => context.pushNamed('parental_control'),
            ),
          ],
        ),
      ),
    );
  }
}
