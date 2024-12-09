import 'package:busycards/config/UI/app_assets.dart';
import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/objects/game_show_me/game_show_me.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/game_show_me/baby_card_game/bloc/baby_card_game_bloc.dart';
import 'package:busycards/presentation/screens/game_show_me/bloc/game_show_me_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BabyCardGame extends StatelessWidget {
  const BabyCardGame(this.babyCard, {super.key});
  final BabyCard babyCard;
  @override
  Widget build(BuildContext context) {
    final audioPlayerService = context.read<AudioPlayerService>();
    final bloc = context.read<GameShowMeBloc>();
    final gameShowMe = context.read<GameShowMe>();
    return BlocProvider(
      key: UniqueKey(),
      create: (context) => sl<BabyCardGameBloc>()
        ..add(
          const BabyCardGameInitialization(),
        ),
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Color(babyCard.color),
              width: 2,
            ),
          ),
          child: BlocBuilder<BabyCardGameBloc, BabyCardGameState>(
            builder: (context, state) {
              switch (state.status) {
                case BabyCardGameStatus.initial:
                case BabyCardGameStatus.failure:
                // return LoadingWidget();
                case BabyCardGameStatus.disabled:
                  return _BabyCardButton(
                    babyCard: babyCard,
                    onTap: null,
                    childStack: null,
                  );
                case BabyCardGameStatus.enabled:
                  return _BabyCardButton(
                    babyCard: babyCard,
                    childStack: null,
                    onTap: () async {
                      final isCheck = gameShowMe.isCheck(babyCard.id);
                      if (isCheck) {
                        audioPlayerService.play(gameShowMe.playAnswerYes());
                        context
                            .read<BabyCardGameBloc>()
                            .add(const BabyCardGameOnTapRight());
                        await Future.delayed(const Duration(milliseconds: 800));
                        if (context.mounted) {
                          await context.pushNamed(
                              RouterPath.pathCongratulationScreen,
                              extra: babyCard.color);

                          bloc.add(const GameShowMeRestart());
                        }
                      } else {
                        audioPlayerService.play(gameShowMe.playAnswerNo());
                        context
                            .read<BabyCardGameBloc>()
                            .add(const BabyCardGameOnTapWrong());
                      }
                    },
                  );
                case BabyCardGameStatus.right:
                  return _BabyCardButton(
                    babyCard: babyCard,
                    onTap: null,
                    childStack: SvgPicture.asset(
                      AppAssets.iconYes,
                      height: 100,
                      width: 100,
                    ),
                  );
                case BabyCardGameStatus.wrong:
                  return _BabyCardButton(
                    babyCard: babyCard,
                    onTap: null,
                    childStack: SvgPicture.asset(
                      AppAssets.iconNo,
                      height: 100,
                      width: 100,
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _BabyCardButton extends StatelessWidget {
  const _BabyCardButton({
    required this.babyCard,
    required this.onTap,
    required this.childStack,
  });
  final BabyCard babyCard;
  final void Function()? onTap;
  final Widget? childStack;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: null,
      child: InkWell(
        splashColor: Color(babyCard.color),
        borderRadius: BorderRadius.circular(23),
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              babyCard.icon,
              fit: BoxFit.fill,
            ),
            childStack ?? Container(),
          ],
        ),
      ),
    );
  }
}
