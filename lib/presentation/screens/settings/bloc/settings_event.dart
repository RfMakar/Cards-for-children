part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsInitialization extends SettingsEvent {
  const SettingsInitialization();
}

final class SettingsSwitchPlayer extends SettingsEvent {
  const SettingsSwitchPlayer(this.isPlay);
  final bool isPlay;
}
