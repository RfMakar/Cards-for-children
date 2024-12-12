enum GameShowMeCardStatus {disabled, enabled, right, wrong}

final class GameShowMeCard {
  final int id;
  final String icon;
  final int color;
  final String audio;
  final String? raw;
   GameShowMeCardStatus status;

   GameShowMeCard({
    required this.id,
    required this.icon,
    required this.color,
    required this.audio,
    required this.raw,
    this.status = GameShowMeCardStatus.disabled,
  });

}
