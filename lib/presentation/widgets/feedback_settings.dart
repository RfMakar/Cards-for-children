import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackAndSettingsWidgets extends StatelessWidget {
  const FeedbackAndSettingsWidgets({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton.feedback(
            onTap: openInBrowser,
          ),
          AppButton.settings(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
