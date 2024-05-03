import 'package:busycards/domain/entities/category_card.dart';

class CategoryCardModel extends CategoryCard {
  CategoryCardModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.audio,
  });

  factory CategoryCardModel.fromMap(Map<String, dynamic> json) =>
      CategoryCardModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        audio: json['audio'],
      );
}
