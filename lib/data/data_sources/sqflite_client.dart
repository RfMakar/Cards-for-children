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
    String path = join(await getDatabasesPath(), 'busy_cards_v2.db');
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
        join('assets', 'db', 'busy_cards_v2.db'),
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
    return await db.query('categories');
  }

  Future<List<Map<String, dynamic>>> getBabyCards({
    required int categoryId,
  }) async {
    final db = await _getDataBase;
    return await db.query(
      'cards',
      where: '"category_id" = ?',
      whereArgs: [categoryId],
    );
  }

  Future<List<Map<String, dynamic>>> getBabyCardsRandom(
      {required int categoryId, required int limit}) async {
    final db = await _getDataBase;
    final sql =
        'SELECT * FROM cards WHERE category_id = $categoryId ORDER BY RANDOM() LIMIT $limit';
    return await db.rawQuery(sql);
  }

  //game
  Future<List<Map<String, dynamic>>> getAnswersGame({
    required int gameId,
    required int result,
  }) async {
    final db = await _getDataBase;
    final sql =
        'SELECT * FROM answers WHERE game_id = $gameId AND result = $result';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> getQuestionsGame({
    required int gameId,
  }) async {
    final db = await _getDataBase;
    return await db.query(
      'questions',
      where: '"game_id" = ? ',
      whereArgs: [gameId],
    );
  }
}
