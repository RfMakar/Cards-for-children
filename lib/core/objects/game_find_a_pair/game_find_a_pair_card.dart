
enum GameFindAPairCardStatus { enabled, select, right, wrong }

final class GameFindAPairCard {
  final int id;
  final int idCard;
  final String icon;
  final int color;
  final GameFindAPairCardStatus status;

  const GameFindAPairCard({
    required this.id,
    required this.idCard,
    required this.icon,
    required this.color,
    this.status = GameFindAPairCardStatus.enabled,
  });

  GameFindAPairCard copyWith({
    required GameFindAPairCardStatus status,
  }) {
    return GameFindAPairCard(
      id: id,
      idCard: idCard,
      icon: icon,
      color: color,
      status: status,
    );
  }
}
