import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/presentation/screens/baby_card/bloc/baby_card_bloc.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/failed.dart';
import 'package:busycards/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BabyCardScreen extends StatefulWidget {
  const BabyCardScreen({super.key, required this.babyCard});
  final BabyCard babyCard;

  @override
  State<BabyCardScreen> createState() => _BabyCardScreenState();
}

class _BabyCardScreenState extends State<BabyCardScreen> {
  late AudioPlayerService _audioPlayerService;
  @override
  void initState() {
    _audioPlayerService = sl<AudioPlayerService>();
    _audioPlayerService.playList(widget.babyCard.audioAndRaw());
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
          create: (context) => sl<BabyCardBloc>()
            ..add(
              BabyCardInitialization(babyCard: widget.babyCard),
            ),
        ),
        Provider(
          create: (context) => widget.babyCard,
        ),
        Provider(
          create: (context) => _audioPlayerService,
        ),
      ],
      child: BodyBabyCardScreen(),
    );
  }
}

class BodyBabyCardScreen extends StatelessWidget {
  const BodyBabyCardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final babyCard = context.read<BabyCard>();
    return Scaffold(
      backgroundColor: Color(babyCard.color).withOpacity(0.6),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 80,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopWidgetBabyCard(),
            ImageWidgetBabyCard(),
            BottomWidgetBabyCard(),
          ],
        ),
      ),
    );
  }
}

class TopWidgetBabyCard extends StatelessWidget {
  const TopWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton.close(
            onTap: context.pop,
          ),
        ],
      ),
    );
  }
}

class ImageWidgetBabyCard extends StatelessWidget {
  const ImageWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final babyCard = context.read<BabyCard>();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.0),
          border: Border.all(
            width: 4,
            color: AppColor.white,
          ),
        ),
        child: InkWell(
          onTap: context.pop,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: Image.asset(
              babyCard.image,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomWidgetBabyCard extends StatelessWidget {
  const BottomWidgetBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final babyCard = context.read<BabyCard>();
    final audioPlayerService = context.read<AudioPlayerService>();
    final isRaw = babyCard.raw != null;
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: isRaw
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton.raw(
                    onTap: () => audioPlayerService.play(
                      babyCard.raw!,
                    ),
                  ),
                  ButtonFavoriteBabyCard(),
                  AppButton.audio(
                    onTap: () => audioPlayerService.play(
                      babyCard.audio,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonFavoriteBabyCard(),
                  AppButton.audio(
                    onTap: () => audioPlayerService.play(
                      babyCard.audio,
                    ),
                  ),
                ],
              ));
  }
}

class ButtonFavoriteBabyCard extends StatelessWidget {
  const ButtonFavoriteBabyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabyCardBloc, BabyCardState>(
      builder: (context, state) {
        switch (state.status) {
          case BabyCardStatus.initial:
          case BabyCardStatus.loading:
            return LoadingWidget();
          case BabyCardStatus.success:
          final babyCard = state.babyCard!;
          return babyCard.isFavorite
              ? AppButton.favorite(
                  onTap: () => context.read<BabyCardBloc>().add(
                        BabyCardsIsFavorite(
                          babyCard: babyCard,
                        ),
                      ),
                )
              : AppButton.notFavorite(
                  onTap: () => context.read<BabyCardBloc>().add(
                        BabyCardsIsFavorite(
                          babyCard: babyCard,
                        ),
                      ),
                );
          case BabyCardStatus.failure:
          return FailedWidget(message: state.error!);
        }
       
      },
    );
  }
}
