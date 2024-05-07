import 'package:busycards/config/UI/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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