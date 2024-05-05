import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/home/home.dart';
import 'package:busycards/presentation/sheets/category_cards_store.dart';
import 'package:busycards/presentation/widgets/button_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class CategoryCardsSheet extends StatelessWidget {
  const CategoryCardsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CategoryCardsList(),
        TopSheet(),
      ],
    );
  }
}

class CategoryCardsList extends StatelessWidget {
  const CategoryCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<CategoryCardsStore>();
    return Observer(
      builder: (_) => store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(8, 58, 8, 8),
              shrinkWrap: true,
              itemCount: store.categorysCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 150,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return CategoryCardWidget(
                  categoryCard: store.categorysCards[index],
                );
              },
            ),
    );
  }
}

class TopSheet extends StatelessWidget {
  const TopSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColor.color2,
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const WidgetButtonStar(),
          const Text(
            'Категории',
            style: TextStyle(
              color: AppColor.color,
              fontSize: 16,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: AppColor.color,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.categoryCard});
  final CategoryCard categoryCard;

  void _playCard() {
    final audioPlayer = AudioPlayer();
    audioPlayer.setUrl(categoryCard.audio);
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _playCard();
        context.pop();
        context.go('/${categoryCard.id}');
        
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(categoryCard.icon),
            ),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Color(categoryCard.color),
              ),
              child: Center(
                child: Text(
                  categoryCard.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColor.color2,
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
