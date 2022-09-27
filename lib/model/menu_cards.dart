class MenuCards {
  final String name;
  final int id;
  final String iconbutton;
  final int click;

  MenuCards({
    required this.name,
    required this.id,
    required this.iconbutton,
    required this.click,
  });

  factory MenuCards.fromMap(Map<String, dynamic> json) => MenuCards(
        name: json['name'],
        id: json['id'],
        iconbutton: json['iconbutton'],
        click: json['click'],
      );
}
