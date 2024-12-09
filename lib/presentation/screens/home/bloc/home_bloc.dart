import 'package:bloc/bloc.dart';
import 'package:busycards/domain/entities/category_card.dart';
import 'package:busycards/domain/repositories/baby_card.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._babyCardRepository) : super( const HomeState()) {
    on<HomeInitialization>(_onInitialization);
  }

  final BabyCardRepository _babyCardRepository;

  void _onInitialization(
    HomeInitialization event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final res = await _babyCardRepository.getCategoriesCards();
    if (res.success) {
      emit(state.copyWith(
        status: HomeStatus.success,
        categorysCards: res.data,
      ));
    } else {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: res.message,
      ));
    }
  }
}
