import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/constants/constants.dart';
import 'package:busycards/core/functions/get_device.dart';
import 'package:busycards/core/functions/open_url_in_browser.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/settings/settings_store.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutScreen(
      body: BodySettingScreen(),
      navigation: ButtomNavigation(),
    );
  }
}

class BodySettingScreen extends StatelessWidget {
  const BodySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();
    return Observer(
      builder: (context) => store.isLoading
          ? const LoadingWidget()
          : const ButtonsSettings(),
    );
  }
}

class ButtonsSettings extends StatelessWidget {
  const ButtonsSettings({super.key});
  void onTapReview() async {
    final device = getDevice();
    if (device == 'android') {
      openUrlInBrowser(urlGooglePlay);
    } else {
      openUrlInBrowser(urlAppStore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Observer(
          builder: (context) => CardsSetting(
            title: 'Музыка',
            pathIcon: store.isAudioBackground
                ? AppAssets.iconVolumeOn
                : AppAssets.iconVolumeOff,
            onTap: store.onOffAudioPlayerBackround,
          ),
        ),
        // CardsSetting(
        //   title: 'Язык',
        //   onTap: () {},
        // ),
        CardsSetting(
          title: 'Оставить отзыв',
          onTap: onTapReview,
        ),
        CardsSetting(
          title: 'Политика конфиденциальности',
          onTap: () => openUrlInBrowser(urlPrivacyPolicy),
        ),
      ],
    );
  }
}

class CardsSetting extends StatelessWidget {
  const CardsSetting({
    super.key,
    required this.title,
    required this.onTap,
    this.pathIcon,
  });
  final String title;
  final String? pathIcon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: AppColor.color,
          //   width: 2,
          // ),
          color: AppColor.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColor.colorMain,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              pathIcon != null
                  ? SvgPicture.asset(
                      pathIcon!,
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        AppColor.colorMain,
                        BlendMode.srcIn,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton.home(
              onTap: context.pop,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
