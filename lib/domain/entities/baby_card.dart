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
}
