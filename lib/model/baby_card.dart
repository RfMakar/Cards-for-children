class BabyCard {
  final String name;
  final String iconbutton;
  final String image;
  final String audio;
  final String? raw;

  BabyCard({
    required this.name,
    required this.iconbutton,
    required this.image,
    required this.audio,
    required this.raw,
  });

  factory BabyCard.fromMap(Map<String, dynamic> json) => BabyCard(
        name: json['name'],
        iconbutton: json['iconbutton'],
        image: json['image'],
        audio: json['audio'],
        raw: json['raw'],
      );
}
