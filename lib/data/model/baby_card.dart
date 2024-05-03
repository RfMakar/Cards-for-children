class BabyCard {
  final int id;
  final String name;
  final String icon;
  final String image;
  final String audio;
  final String? raw;

  BabyCard({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.audio,
    required this.raw,
  });

  factory BabyCard.fromMap(Map<String, dynamic> json) => BabyCard(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        image: json['image'],
        audio: json['audio'],
        raw: json['raw'],
      );
}
