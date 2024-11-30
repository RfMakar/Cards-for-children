part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoadInProgress extends SettingsState {
  const SettingsLoadInProgress();
}

final class SettingsLoadSucces extends SettingsState {
  const SettingsLoadSucces(this.isPlay);
  final bool isPlay;
}

final class SettingsLoadFailed extends SettingsState {
  const SettingsLoadFailed(this.message);
  final String message;
}
