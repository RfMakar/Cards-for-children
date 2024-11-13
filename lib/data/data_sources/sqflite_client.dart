import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteClientApp {
  Database? _database;

  Future<Database> get _getDataBase async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'baby_cards_ru_v2.db');
    await _copyDatabase(path);
    return await openDatabase(
      path,
      version: 1,
    );
  }

  Future<void> _copyDatabase(String path) async {
    var exists = await databaseExists(path);
    if (!exists) {
      //Если БД не существует то копируем из ресурсов
      ByteData data = await rootBundle.load(
        join('assets', 'database', 'baby_cards_ru_v2.db'),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      //Запись и очистка записанных байтов
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  Future<List<Map<String, dynamic>>> getCategoriesCards() async {
    final db = await _getDataBase;
    const sql = '''
    SELECT categories.id, categories.name, categories.icon, categories.audio, colors.value AS color 
    FROM categories
    JOIN colors ON colors.id = categories.color_id;
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> getBabyCards({
    required int categoryId,
  }) async {
    final db = await _getDataBase;
    var sql = '''
    SELECT cards.id, cards.name, cards.icon, cards.image, cards.raw, cards.audio, colors.value AS color, cards.favorite
    FROM cards
    JOIN colors ON colors.id = cards.color_id
    WHERE category_id = $categoryId;
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> getBabyCardsFavorite() async {
    final db = await _getDataBase;
    var sql = '''
    SELECT cards.id, cards.name, cards.icon, cards.image, cards.raw, cards.audio, colors.value AS color, cards.favorite
    FROM cards
    JOIN colors ON colors.id = cards.color_id
    WHERE favorite = 1;
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> getBabyCardsRandom(
      {required int categoryId, required int limit}) async {
    final db = await _getDataBase;
    final sql = '''
    SELECT cards.id, cards.name, cards.icon, cards.image, cards.raw, cards.audio, colors.value AS color, cards.favorite
    FROM cards
    JOIN colors ON colors.id = cards.color_id
    WHERE category_id = $categoryId 
    ORDER BY RANDOM() 
    LIMIT $limit;
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> putBabyCard(int babyCardId, int isFavorite) async {
    final db = await _getDataBase;
    final sql = '''
    UPDATE cards
    SET favorite = $isFavorite
    WHERE id = $babyCardId 
    ''';
    return await db.rawUpdate(sql);
  }

  //game
  Future<List<Map<String, dynamic>>> getAnswersGame({
    required int gameId,
    required int result,
  }) async {
    final db = await _getDataBase;
    final sql = '''
    SELECT * 
    FROM answers 
    WHERE game_id = $gameId AND result = $result;
    ''';
    return db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> getQuestionsGame({
    required int gameId,
  }) async {
    final db = await _getDataBase;
    final sql = '''
    SELECT *
    FROM questions
    WHERE game_id = $gameId;
    ''';
    return db.rawQuery(sql);
  }
}
