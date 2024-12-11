import 'package:busycards/config/UI/app_assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageStarWidget extends StatelessWidget {
  final String assetName;

  const ImageStarWidget.congratulation({
    super.key,
  }) : assetName = AppAssets.imageStarCongratulation;
  const ImageStarWidget.empty({
    super.key,
  }) : assetName = AppAssets.imageStarEmpty;
  const ImageStarWidget.error({
    super.key,
  }) : assetName = AppAssets.imageStarError;
  const ImageStarWidget.favorite({
    super.key,
  }) : assetName = AppAssets.imageStarFavorite;
  const ImageStarWidget.notFavorite({
    super.key,
  }) : assetName = AppAssets.imageStarNotFavorite;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        height: 300,
        assetName,
        fit: BoxFit.fill,
      ),
    );
  }
}
