import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/core/objects/game_show_me.dart';
import 'package:busycards/presentation/screens/game_show_me/baby_card_game/baby_card_game.dart';
import 'package:busycards/presentation/screens/game_show_me/bloc/game_show_me_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
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
        navigation: _ButtomNavigation(),
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
    final selectedBabyCards = context.read<GameShowMe>().selectedBabyCards;
    return Center(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
        itemCount: selectedBabyCards.length,
        itemBuilder: (context, index) {
          final babyCard = selectedBabyCards[index];
          return BabyCardGame(babyCard);
        },
      ),
    );
  }
}

class _ButtomNavigation extends StatelessWidget {
  const _ButtomNavigation();

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
            AppButton.from(
              onTap: context.pop,
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
