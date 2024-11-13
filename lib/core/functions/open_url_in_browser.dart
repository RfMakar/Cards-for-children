import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrlInBrowser(String path) async {
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
