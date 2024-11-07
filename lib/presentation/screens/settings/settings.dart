import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/constants/constants.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutScreen(
      body: BodySettingScreen(),
      navigation: ButtomNavigation(),
    );
  }
}

class BodySettingScreen extends StatelessWidget {
  const BodySettingScreen({super.key});

  Future<void> openInBrowser(String path) async {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CardsSetting(
        //   title: 'Язык',
        //   onTap: () {},
        // ),
        // CardsSetting(
        //   title: 'Оставить отзыв',
        //   onTap: () => openInBrowser(urlGooglePlay),
        // ),
        CardsSetting(
          title: 'Политика конфиденциальности',
          onTap: () => openInBrowser(urlPrivacyPolicy),
        ),
      ],
    );
  }
}

class CardsSetting extends StatelessWidget {
  const CardsSetting({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.color,
            width: 2,
          ),
          color: AppColor.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              // color: AppColor.color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
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
            AppButton.from(
              onTap: () => context.pushNamed('nome_screen'),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
