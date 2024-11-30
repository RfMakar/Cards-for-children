import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._babyCardRepository) : super(HomeInitial()) {
    on<HomeInitialization>(_onInitialization);
  }

  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    HomeInitialization event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadInProgress());
    final res = await _babyCardRepository.getCategoriesCards();
    if (res.success) {
      emit(HomeLoadSucces(categorysCards: res.data!));
    } else {
      emit(HomeLoadFailed(res.message!));
    }
  }
}
