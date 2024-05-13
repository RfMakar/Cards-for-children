import 'package:busycards/domain/entities/question_game.dart';

class QuestionGameModel extends QuestionGame {
  QuestionGameModel({
    required super.id,
    required super.name,
    required super.audio,
  });
  factory QuestionGameModel.fromJson(Map<String, dynamic> json) => QuestionGameModel(
        id: json['id'],
        name: json['name'],
        audio: json['audio'],
      );
}
