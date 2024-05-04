import 'package:busycards/domain/entities/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCardModel extends CategoryCard {
  CategoryCardModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.audio,
    required super.color,
  });

  factory CategoryCardModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return CategoryCardModel(
      id: data['id'],
      name: data['name'],
      icon: data['icon'],
      audio: data['audio'],
      color: data['color'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'audio': audio,
      'color' : color,
    };
  }

  factory CategoryCardModel.fromMap(Map<String, dynamic> json) =>
      CategoryCardModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        audio: json['audio'],
         color: json['color'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'audio': audio,
      'color' : color,
    };
  }
}
