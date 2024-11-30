import 'package:bloc/bloc.dart';
import 'package:busycards/core/service/audio_background.dart';
import 'package:busycards/core/service/storage_local.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._storageLocalService, this._audioBackgroundService)
      : super(SettingsInitial()) {
    on<SettingsInitialization>(_onInitialization);
    on<SettingsSwitchPlayer>(_switchPlayer);
  }

  final StorageLocalService _storageLocalService;
  final AudioBackgroundService _audioBackgroundService;

  void _onInitialization(
    SettingsInitialization event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoadInProgress());
    try {
      final isPlay = await _storageLocalService.getAudioBackground();
      emit(SettingsLoadSucces(isPlay));
    } catch (e) {
      emit(SettingsLoadFailed(e.toString()));
    }
  }

  void _switchPlayer(
    SettingsSwitchPlayer event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      if(event.isPlay){
        _audioBackgroundService.play();
      }else{
        _audioBackgroundService.stop();
      }
      emit(SettingsLoadSucces(event.isPlay));
      await _storageLocalService.setAudioBackground(event.isPlay);

    } catch (e) {
      emit(SettingsLoadFailed(e.toString()));
    }
  }
}
