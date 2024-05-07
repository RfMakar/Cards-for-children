import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String assetName;

  const AppButton.feedback({super.key, required this.onTap})
      : assetName = AppAssets.iconFeedBack;
        const AppButton.settings({super.key, required this.onTap})
      : assetName = AppAssets.iconSettings;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: AppColor.color2,
      onTap: onTap,
      child: SvgPicture.asset(
        assetName,
        fit: BoxFit.fill,
        height: 60,
        width: 60,
      ),
    );
  }
}
