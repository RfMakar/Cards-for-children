import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String assetName;

  const AppButton.favorite({super.key, required this.onTap})
      : assetName = AppAssets.iconFavorite;
       const AppButton.notFavorite({super.key, required this.onTap})
      : assetName = AppAssets.iconNotFavorite;
  const AppButton.settings({super.key, required this.onTap})
      : assetName = AppAssets.iconSettings;
  const AppButton.home({super.key, required this.onTap})
      : assetName = AppAssets.iconHome;
  const AppButton.game({super.key, required this.onTap})
      : assetName = AppAssets.iconGame;
  const AppButton.close({super.key, required this.onTap})
      : assetName = AppAssets.iconClose;
  const AppButton.raw({super.key, required this.onTap})
      : assetName = AppAssets.iconRaw;
  const AppButton.audio({super.key, required this.onTap})
      : assetName = AppAssets.iconAudio;
  const AppButton.from({super.key, required this.onTap})
      : assetName = AppAssets.iconFrom;
  const AppButton.to({super.key, required this.onTap})
      : assetName = AppAssets.iconTo;
  const AppButton.query({super.key, required this.onTap})
      : assetName = AppAssets.iconQuery;
  const AppButton.reset({super.key, required this.onTap})
      : assetName = AppAssets.iconReset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColor.transparent,
      focusColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
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
