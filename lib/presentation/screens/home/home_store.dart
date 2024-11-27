import 'package:audioplayers/audioplayers.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final BabyCardRepository _babyCardRepository;
  final AudioPlayer _audioPlayer;

  _HomeStore({
    required BabyCardRepository babyCardRepository,
    required AudioPlayer audioPlayer,
  })  : _babyCardRepository = babyCardRepository,
        _audioPlayer = audioPlayer;

  Future<void> init() async {
    await _getCategoriesCards();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  List<CategoryCard> categorysCards = [];

  @action
  Future<void> _getCategoriesCards() async {
    final res = await _babyCardRepository.getCategoriesCards();
    categorysCards = res;
  }

  void playAudioPlayer(CategoryCard categoryCard) {
    final source = AssetSource(categoryCard.audio);
    _audioPlayer.play(source);
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }
}
