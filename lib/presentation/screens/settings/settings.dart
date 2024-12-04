import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/constants/constants.dart';
import 'package:busycards/core/functions/get_device.dart';
import 'package:busycards/core/functions/open_url_in_browser.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/settings/bloc/settings_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(SettingsInitialization()),
      child: const LayoutScreen(
        body: BodySettingScreen(),
        navigation: ButtomNavigation(),
      ),
    );
  }
}

class BodySettingScreen extends StatelessWidget {
  const BodySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        switch (state.status) {
          case SettingsStatus.initial:
          case SettingsStatus.loading:
            return LoadingWidget();
          case SettingsStatus.success:
            return ButtonsSettings();
          case SettingsStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if ( SettingsStatus.success == state.status) {
              return CardsSetting(
                title: 'Музыка',
                pathIcon: state.isPlay!
                    ? AppAssets.iconVolumeOn
                    : AppAssets.iconVolumeOff,
                onTap: () {
                  context.read<SettingsBloc>().add(
                        SettingsSwitchPlayer(
                          !state.isPlay!,
                        ),
                      );
                },
              );
            }
            return Container();
          },
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
