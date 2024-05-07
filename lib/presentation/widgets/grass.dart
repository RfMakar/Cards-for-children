import 'package:busycards/config/UI/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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