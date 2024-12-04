import 'package:bloc/bloc.dart';
import 'package:busycards/core/service/audio_background.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._storageLocalService,
    this._audioBackgroundService,
  ) : super(SettingsState()) {
    on<SettingsInitialization>(_onInitialization);
    on<SettingsSwitchPlayer>(_switchPlayer);
  }

  final StorageLocalService _storageLocalService;
  final AudioBackgroundService _audioBackgroundService;

  void _onInitialization(
    SettingsInitialization event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      final isPlay = await _storageLocalService.getAudioBackground();
      emit(state.copyWith(
        status: SettingsStatus.success,
        isPlay: isPlay,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SettingsStatus.failure,
        error: '',
      ));
    }
  }

  void _switchPlayer(
    SettingsSwitchPlayer event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      if (event.isPlay) {
        _audioBackgroundService.play();
      } else {
        _audioBackgroundService.stop();
      }
      emit(state.copyWith(
        status: SettingsStatus.success,
        isPlay: event.isPlay,
      ));
      await _storageLocalService.setAudioBackground(event.isPlay);
    } catch (e) {
      emit(state.copyWith(
        status: SettingsStatus.failure,
        error: '',
      ));
    }
  }
}
