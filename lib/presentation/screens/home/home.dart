import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/presentation/screens/home/bloc/home_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late AudioPlayerService _audioPlayerService;

  //ad
  late final Future<AppOpenAdLoader> _appOpenAdLoader; // загрузчик
  AppOpenAd? _appOpenAd; //рекламное обьявление
  static var isAdShowing = false; //state показа
  static var isColdStartAdShow =
      false; //state холодного показа холодного старта

  @override
  void initState() {
    super.initState();
    MobileAds.initialize();
    _appOpenAdLoader = _createAppOpenAdLoader();
    _loadAppOpenAd();
    _audioPlayerService = sl<AudioPlayerService>();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _showAdIfAvailable();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _initLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    Intl.defaultLocale = locale.languageCode;
  }

  Future<void> _loadAppOpenAd() async {
    final adLoader = await _appOpenAdLoader;
    adLoader.loadAd(adRequestConfiguration: _adRequestConfiguration());
  }

  AdRequestConfiguration _adRequestConfiguration() {
    final adUnitId = 'demo-appopenad-yandex';
    // final adUnitId = 'R-M-13983257-1'; //ru store
    // final adUnitId = 'R-M-13836573-1'; //app store
    // final adUnitId = 'R-M-13836524-1'; //play store
    return AdRequestConfiguration(adUnitId: adUnitId);
  }

  //создание рекламного блока
  Future<AppOpenAdLoader> _createAppOpenAdLoader() {
    return AppOpenAdLoader.create(
      onAdLoaded: (AppOpenAd appOpenAd) {
        _appOpenAd = appOpenAd;
        print('>>> реклама загружена');

        if (!isColdStartAdShow) {
          _showAdIfAvailable();
          isColdStartAdShow = true;
        }
      },
      onAdFailedToLoad: (error) {},
    );
  }

  Future<void> _showAdIfAvailable() async {
    var appOpenAd = _appOpenAd;
    if (appOpenAd != null && !isAdShowing) {
      _setAdEventListener(appOpenAd: appOpenAd);
      await appOpenAd.show();
      await appOpenAd.waitForDismiss();
    } else {
      _loadAppOpenAd();
    }
  }

  //подписка на жизненый цикл обьявления
  void _setAdEventListener({required AppOpenAd appOpenAd}) {
    appOpenAd.setAdEventListener(
      eventListener: AppOpenAdEventListener(
        onAdShown: () {
          debugPrint('>>>onAdShown');
          isAdShowing = true;
        },
        onAdFailedToShow: (error) {
          debugPrint('>>>onAdFailedToShow');
          isAdShowing = false;
          _clearAppOpenAd();
        },
        onAdDismissed: () {
          debugPrint('>>>onAdDismissed');
          isAdShowing = false;
          _clearAppOpenAd();
          _loadAppOpenAd();
        },
        onAdClicked: () {
          debugPrint('>>>onAdClicked');
        },
        onAdImpression: (data) {
          debugPrint('>>>onAdImpression');
        },
      ),
    );
  }

  void _clearAppOpenAd() {
    _appOpenAd?.destroy();
    _appOpenAd = null;
  }

  @override
  Widget build(BuildContext context) {
    _initLocale(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>()..add(const HomeInitialization()),
        ),
        Provider(
          create: (context) => _audioPlayerService,
        ),
      ],
      child: const LayoutScreen(
        body: BodyHomeScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationHomeFavorite(),
            ButtonNavigationHomeSettings(),
          ],
        ),
      ),
    );
  }
}

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initial:
          case HomeStatus.loading:
            return const LoadingWidget();
          case HomeStatus.success:
            return CategoryCardsList(
              categorysCards: state.categorysCards,
            );
          case HomeStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class CategoryCardsList extends StatelessWidget {
  const CategoryCardsList({super.key, required this.categorysCards});
  final List<CategoryCard> categorysCards;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final audioPlayerService = context.read<AudioPlayerService>();
    return GridView.builder(
      scrollDirection:
          orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: height > 1000 ? 3 : 2,
        childAspectRatio: orientation == Orientation.portrait ? 0.80 : 1.2,
      ),
      padding: orientation == Orientation.portrait
          ? const EdgeInsets.fromLTRB(8, 8, 8, 80)
          : const EdgeInsets.fromLTRB(32, 8, 80, 8),
      itemCount: categorysCards.length,
      itemBuilder: (context, index) {
        final categoryCard = categorysCards[index];
        return CategoryCardWidget(
          categoryCard: categoryCard,
          onTap: () {
            audioPlayerService.play(categoryCard.audio);
            context.pushNamed(
              RouterPath.pathBabyCardsScreen,
              extra: categoryCard.id,
            );
          },
        );
      },
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.categoryCard,
    required this.onTap,
  });

  final CategoryCard categoryCard;
  final Function() onTap;
  final radius = 12.0;
  final borderWidht = 2.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(categoryCard.color).withOpacity(0.9),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: AppColor.white,
            width: borderWidht,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                categoryCard.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 2,
                right: 2,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                categoryCard.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(
                  color: AppColor.white,
                  // color: Color(categoryCard.color),
                  // fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonNavigationHomeFavorite extends StatelessWidget {
  const ButtonNavigationHomeFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.notFavorite(
      onTap: () => context.pushNamed(
        RouterPath.pathFavoriteBabyCardsScreen,
      ),
    );
  }
}

class ButtonNavigationHomeSettings extends StatelessWidget {
  const ButtonNavigationHomeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.settings(
      onTap: () => context.pushNamed(
        RouterPath.pathParentalControlScreen,
      ),
    );
  }
}
