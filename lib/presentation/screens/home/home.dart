import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/initialize_dependencie.dart';
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
        padding: const EdgeInsets.only(
          bottom: 100,
          top: 4,
          left: 4,
          right: 4,
        ),
        //mainAxisSpacing: 1,
        childAspectRatio: 0.80,
        crossAxisCount: 3,
        children: List.generate(
          store.categorysCards.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 3,
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

  void _playAudio() {
    sl<AudioPlayerService>().playAudio(
      categoryCard.audio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () {
        _playAudio();
        context.pushNamed(
          'baby_cards_screen',
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
        child: Image.asset(categoryCard.icon),
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
            const SizedBox(),
            AppButton.settings(
              onTap: () => context.pushNamed('settings_screen'),
            ),
          ],
        ),
      ),
    );
  }
}
