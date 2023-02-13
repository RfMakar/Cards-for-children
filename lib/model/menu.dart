class Menu {
  final int id;
  final String name;
  final String icon;

  Menu({required this.id, required this.name, required this.icon});

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
      );
}
