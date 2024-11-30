class BabyCard {
  final int id;
  final String name;
  final String icon;
  final String image;
  final String audio;
  final int color;
  final String? raw;
  bool isFavorite;

  BabyCard({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.audio,
    required this.color,
    required this.raw,
    required this.isFavorite,
  });

  List<String> audioAndRaw() {
    return [audio, raw].whereType<String>().toList();
  }

  BabyCard copyWith({ bool? isFavorite}) => BabyCard(
        id: id,
        name: name,
        icon: icon,
        image: image,
        audio: audio,
        color: color,
        raw: raw,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
