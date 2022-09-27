import 'dart:io';
import 'package:busycards/data/db_menu_cards.dart';
import 'package:busycards/model/baby_card.dart';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBBabyCards {
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'busycards.db');

    var exists = await databaseExists(path);
    if (!exists) {
      //Если БД не существует то копируем из ресурсов
      ByteData data =
          await rootBundle.load(join('assets', 'db', 'busycards.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Запись и очистка записанных байтов
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  static Future<List<BabyCard>> getListCards() async {
    late String nameTable;
    //Определяет какая кнопка нажата
    var id = await DBMenuCards.idMenuTable();
    switch (id) {
      case 0:
        nameTable = Table.animals;
        break;
      case 1:
        nameTable = Table.fruitsandvegetables;
        break;
      case 2:
        nameTable = Table.transport;
        break;
      case 3:
        nameTable = Table.street;
        break;
      case 4:
        nameTable = Table.food;
        break;
      case 5:
        nameTable = Table.electronics;
        break;
      case 6:
        nameTable = Table.home;
        break;
      case 7:
        nameTable = Table.clothes;
        break;
      case 8:
        nameTable = Table.human;
        break;
      case 9:
        nameTable = Table.letters;
        break;
      case 10:
        nameTable = Table.figures;
        break;
      case 11:
        nameTable = Table.colors;
        break;
      case 12:
        nameTable = Table.numbers;
        break;
      default:
        nameTable = Table.animals;
        break;
    }
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM $nameTable;');
    List<BabyCard> list =
        maps.isNotEmpty ? maps.map((e) => BabyCard.fromMap(e)).toList() : [];
    return list;
  }
}

abstract class Table {
  static const animals = 'animals';
  static const fruitsandvegetables = 'fruitsandvegetables';
  static const transport = 'transport';
  static const street = 'street';
  static const food = 'food';
  static const electronics = 'electronics';
  static const home = 'home';
  static const clothes = 'clothes';
  static const human = 'human';
  static const letters = 'letters';
  static const figures = 'figures';
  static const colors = 'colors';
  static const numbers = 'numbers';
}
