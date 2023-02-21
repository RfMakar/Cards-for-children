class Menu {
  final int id;
  final String name;
  final String icon;
  final String? audio;

  Menu(
      {required this.id,
      required this.name,
      required this.icon,
      required this.audio});

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        audio: json['audio'],
      );
}
