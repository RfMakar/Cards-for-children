import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/core/objects/game_show_me.dart';
import 'package:busycards/presentation/screens/game_show_me/baby_card_game/baby_card_game.dart';
import 'package:busycards/presentation/screens/game_show_me/bloc/game_show_me_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/layout_bottom_navigation.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class GameShowMeScreen extends StatefulWidget {
  const GameShowMeScreen({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<GameShowMeScreen> createState() => _GameShowMeScreenState();
}

class _GameShowMeScreenState extends State<GameShowMeScreen> {
  late AudioPlayerService _audioPlayerService;
  @override
  void initState() {
    _audioPlayerService = sl<AudioPlayerService>();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GameShowMeBloc>()
            ..add(
              GameShowMeInitialization(
                widget.categoryId,
              ),
            ),
        ),
        Provider(
          create: (context) => _audioPlayerService,
        ),
        Provider(
          create: (context) => widget.categoryId,
        ),
      ],
      child: const LayoutScreen(
        body: _BodyGameShowMeScreen(),
        bottomNavigation: LayoutButtomNavigation(
          children: [
            ButtonNavigationGameShoweMeFrom(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _BodyGameShowMeScreen extends StatelessWidget {
  const _BodyGameShowMeScreen();

  @override
  Widget build(BuildContext context) {
    final audioPlayerService = context.read<AudioPlayerService>();
    return BlocBuilder<GameShowMeBloc, GameShowMeState>(
      builder: (context, state) {
        switch (state.status) {
          case GameShowMeStatus.initial:
          case GameShowMeStatus.loading:
            return LoadingWidget();
          case GameShowMeStatus.success:
            audioPlayerService.playList(state.gameShowMe!.playQuestion());
            return Provider(
              create: (context) => state.gameShowMe,
              child: _BabyCardsList(),
            );
          case GameShowMeStatus.failure:
            return FailedWidget(message: state.error!);
        }
      },
    );
  }
}

class _BabyCardsList extends StatelessWidget {
  const _BabyCardsList();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.portrait:
        return BabyCardsPortrait();
      case Orientation.landscape:
        return BabyCardsLandscape();
    }
  }
}

class BabyCardsPortrait extends StatelessWidget {
  const BabyCardsPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final selectedBabyCards = context.read<GameShowMe>().selectedBabyCards;
    return SingleChildScrollView(
      padding: height > 1000 ? EdgeInsets.all(140) : EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              BabyCardGame(selectedBabyCards[0]),
              BabyCardGame(selectedBabyCards[1]),
            ],
          ),
          Row(
            children: [
              BabyCardGame(selectedBabyCards[2]),
              BabyCardGame(selectedBabyCards[3]),
            ],
          ),
          Row(
            children: [
              BabyCardGame(selectedBabyCards[4]),
              BabyCardGame(selectedBabyCards[5]),
            ],
          ),
        ],
      ),
    );
  }
}

class BabyCardsLandscape extends StatelessWidget {
  const BabyCardsLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedBabyCards = context.read<GameShowMe>().selectedBabyCards;
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 160, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                BabyCardGame(selectedBabyCards[0]),
                BabyCardGame(selectedBabyCards[1]),
                BabyCardGame(selectedBabyCards[2]),
              ],
            ),
            Row(
              children: [
                BabyCardGame(selectedBabyCards[3]),
                BabyCardGame(selectedBabyCards[4]),
                BabyCardGame(selectedBabyCards[5]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonNavigationGameShoweMeFrom extends StatelessWidget {
  const ButtonNavigationGameShoweMeFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.from(
      onTap: context.pop,
    );
  }
}
