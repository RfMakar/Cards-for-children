import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/UI/app_text_style.dart';
import 'package:busycards/data/service/audio_player.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:busycards/presentation/widgets/feedback_settings.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutScreen(
      body: CategoriesCardsList(),
      navigation: FeedbackAndSettingsWidgets(),
    );
  }
}

class CategoriesCardsList extends StatelessWidget {
  const CategoriesCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return Observer(
      builder: (_) => store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 100,
                top: 50,
                left: 72,
                right: 72,
              ),
              itemCount: store.categorysCards.length,
              itemBuilder: (context, index) {
                return CategoryCardWidget(
                  categoryCard: store.categorysCards[index],
                );
              },
            ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.categoryCard});
  final CategoryCard categoryCard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          sl<AudioPlayerService>().audioPlayerPlay(categoryCard.audio);
          //_playCard();
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
              color: AppColor.color2,
              width: 6,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                categoryCard.icon,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryCard.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: AppTextStyle.textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
