import 'package:busycards/core/service/audio_player.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'baby_card_store.g.dart';

// ignore: library_private_types_in_public_api
class BabyCardStore = _BabyCardStore with _$BabyCardStore;

abstract class _BabyCardStore with Store {
  final BabyCardRepository _babyCardRepository;
  final AudioPlayerService _audioPlayerService;
  final BabyCard babyCard;

  _BabyCardStore({
    required BabyCardRepository babyCardRepository,
    required AudioPlayerService audioPlayerService,
    required this.babyCard,
  })  : _babyCardRepository = babyCardRepository,
        _audioPlayerService = audioPlayerService;

  Future<void> init() async {
    _playAudioAndRawBabyCard();
    isFavoriteBabyCards = babyCard.isFavorite;
  }

  @observable
  late bool isFavoriteBabyCards;

  @action
  Future<void> updateFavoriteBabyCard() async {
    final isResultFavorite = !isFavoriteBabyCards;
    final isResultUpdateFavorite = await _babyCardRepository.updateBabyCard(
      babyCardId: babyCard.id,
      isFavorite: isResultFavorite,
    );
    if (isResultUpdateFavorite) {
      isFavoriteBabyCards = isResultFavorite;
      babyCard.isFavorite = isResultFavorite;
    }
  }

  void _playAudioAndRawBabyCard() async {
    final assetsPath = [
      babyCard.audio,
      babyCard.raw,
    ];
    _audioPlayerService.playAudioList(assetsPath);
  }

  void playAudioBabyCard() => _audioPlayerService.playAudio(babyCard.audio);

  void playRawBabyCard() => _audioPlayerService.playAudio(babyCard.raw!);

  void dispose(){
    _audioPlayerService.dispose();
  }
}
