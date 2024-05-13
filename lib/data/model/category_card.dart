import 'package:busycards/domain/entities/category_card.dart';

class CategoryCardModel extends CategoryCard {
  CategoryCardModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.audio,
    required super.color,
  });

  factory CategoryCardModel.fromJson(Map<String, dynamic> json) =>
      CategoryCardModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        audio: json['audio'],
        color: json['color'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'audio': audio,
      'color': color,
    };
  }
}
