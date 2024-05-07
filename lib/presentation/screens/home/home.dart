import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/initialize_dependencie.dart';
import 'package:busycards/presentation/screens/home/home_store.dart';
import 'package:busycards/presentation/widgets/cloud.dart';
import 'package:busycards/presentation/widgets/feedback_settings.dart';
import 'package:busycards/presentation/widgets/grass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.color3,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CloudWidget(),
            CategoriesCardsList(),
            GrassWidget(),
            FeedbackAndSettingsWidgets(),
          ],
        ),
      ),
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

  void _playCard() {
    final audioPlayer = AudioPlayer();
    audioPlayer.setAsset(categoryCard.audio);
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          _playCard();
          //context.go('/${categoryCard.id}');
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
              SizedBox(
                height: 230,
                child: Image.asset(
                  categoryCard.icon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryCard.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: AppColor.color2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
