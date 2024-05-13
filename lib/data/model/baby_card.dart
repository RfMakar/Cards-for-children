import 'package:busycards/domain/entities/baby_card.dart';

class BabyCardModel extends BabyCard {
  BabyCardModel({
    required super.name,
    required super.icon,
    required super.image,
    required super.audio,
    required super.color,
    required super.raw,
  });

  factory BabyCardModel.fromJson(Map<String, dynamic> json) => BabyCardModel(
        name: json['name'],
        icon: json['icon'],
        image: json['image'],
        audio: json['audio'],
        color: json['color'],
        raw: json['raw'],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'image': image,
      'audio': audio,
      'color': color,
      'raw': raw,
    };
  }
}
