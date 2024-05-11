import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/data/service/audio_player.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          top: 50,
          left: 72,
          right: 72,
        ),
        mainAxisSpacing: 32,
        crossAxisCount: 1,
        children: List.generate(
          store.categorysCards.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 1,
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
  const CategoryCardWidget({super.key, required this.categoryCard});
  final CategoryCard categoryCard;
  void _playAudio() {
    sl<AudioPlayerService>().audioPlayerPlay(
      categoryCard.audio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        _playAudio();
        context.pushNamed(
          'baby_cards_screen',
          extra: categoryCard.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(categoryCard.color),
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          border: Border.all(
            color: AppColor.white,
            width: 5,
          ),
        ),
        child: Image.asset(
          categoryCard.icon,
        ),
      ),
    );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  Future<void> openInBrowser() async {
    const path =
        'https://play.google.com/store/apps/details?id=com.dom.busycards';
    final Uri launchUri = Uri.parse(path);
    try {
      await launchUrl(
        launchUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton.feedback(
              onTap: openInBrowser,
            ),
            // AppButton.settings(
            //   onTap: () {},
            // ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
