import 'package:busycards/domain/entities/answer_game.dart';

class AnswerGameModel extends AnswerGame {
  AnswerGameModel({
    required super.id,
    required super.name,
    required super.audio,
  });
  factory AnswerGameModel.fromMap(Map<String, dynamic> json) => AnswerGameModel(
        id: json['id'],
        name: json['name'],
        audio: json['audio'],
      );
}
