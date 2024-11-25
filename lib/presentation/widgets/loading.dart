import 'package:busycards/config/UI/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        height: 200,
        width: 200,
        AppAssets.iconLoading,
      ),
    );
  }
}
