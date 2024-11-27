import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'baby_card_store.g.dart';

// ignore: library_private_types_in_public_api
class BabyCardStore = _BabyCardStore with _$BabyCardStore;

abstract class _BabyCardStore with Store {
  final BabyCardRepository _babyCardRepository;
  final AudioPlayer _audioPlayer;
  final BabyCard babyCard;

  _BabyCardStore({
    required BabyCardRepository babyCardRepository,
    required AudioPlayer audioPlayer,
    required this.babyCard,
  })  : _babyCardRepository = babyCardRepository,
        _audioPlayer = audioPlayer;

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
    final assetsSource = <AssetSource>[];

    for (var path in babyCard.audioAndRaw()) {
      assetsSource.add(AssetSource(path));
    }

    await _audioPlayer.play(assetsSource.first);
    int i = 1;
    _audioPlayer.onPlayerComplete.listen(
      (_) async {
        if (i < assetsSource.length) {
          await _audioPlayer.play(assetsSource[i]);
          i++;
        }
      },
    );
  }

  void playAudioBabyCard() {
    final source = AssetSource(babyCard.audio);
    _audioPlayer.play(source);
  }

  void playRawBabyCard() {
    final source = AssetSource(babyCard.raw!);
    _audioPlayer.play(source);
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }
}
