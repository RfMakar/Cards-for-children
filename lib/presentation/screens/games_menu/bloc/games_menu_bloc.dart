import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'games_menu_event.dart';
part 'games_menu_state.dart';

class GamesMenuBloc extends Bloc<GamesMenuEvent, GamesMenuState> {
  GamesMenuBloc(this._babyCardRepository) : super(GamesMenuInitial()) {
    on<GamesMenuInitialization>(_onInitialization);
  }

  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    GamesMenuInitialization event,
    Emitter<GamesMenuState> emit,
  ) async {
    emit(GamesMenuLoadInProgress());
    final res = await _babyCardRepository.getBabyCards(
      categoryId: event.categoryId,
    );
    if (res.success) {
      emit(GamesMenuLoadSucces(babyCards: res.data!));
    } else {
      emit(GamesMenuLoadFailed(res.message!));
    }
  }
}
