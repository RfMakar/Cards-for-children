import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetButtonStar extends StatelessWidget {
  const WidgetButtonStar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final Uri url = Uri.parse(
            'https://play.google.com/store/apps/details?id=com.dom.busycards');

        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          throw 'Could not launch $url';
        }
      },
      icon: const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 30,
      ),
    );
  }
}
