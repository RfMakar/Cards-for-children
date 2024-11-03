import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({
    super.key,
    required this.body,
    required this.navigation,
  });
  final Widget body;
  final Widget navigation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const CloudWidget(),
            const GrassWidget(),
            body,
            navigation,
          ],
        ),
      ),
    );
  }
}

class CloudWidget extends StatelessWidget {
  const CloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SvgPicture.asset(
        AppAssets.imageCloud,
        fit: BoxFit.fill,
      ),
    );
  }
}

class GrassWidget extends StatelessWidget {
  const GrassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        AppAssets.imageGrass,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
