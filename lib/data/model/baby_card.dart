import 'package:busycards/domain/entities/baby_card.dart';

class BabyCardModel extends BabyCard {
  BabyCardModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.image,
    required super.audio,
    required super.color,
    required super.raw,
    required super.isFavorite,
  });

  factory BabyCardModel.fromJson(Map<String, dynamic> json) => BabyCardModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        image: json['image'],
        audio: json['audio'],
        color: json['color'],
        raw: json['raw'],
        isFavorite: json['favorite'] == 0 ? false : true,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'image': image,
      'audio': audio,
      'color': color,
      'raw': raw,
      'favorite': isFavorite ? 1 : 0,
    };
  }
}
