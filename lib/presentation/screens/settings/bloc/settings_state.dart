part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, failure }

final class SettingsState {
  const SettingsState({
    this.status = SettingsStatus.initial,
    this.isPlay,
    this.error,
  });
  final SettingsStatus status;
  final bool? isPlay;
  final String? error;

  SettingsState copyWith({
    SettingsStatus? status,
    bool? isPlay,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isPlay: isPlay ?? this.isPlay,
      error: error ?? this.error,
    );
  }
}
