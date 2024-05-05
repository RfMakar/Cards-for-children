import 'dart:io';
import 'package:busycards/data/model/baby_card.dart';
import 'package:busycards/data/model/category_card.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBBabyCards {
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'busycards_1.4.db');

    var exists = await databaseExists(path);
    if (!exists) {
      //Если БД не существует то копируем из ресурсов
      ByteData data =
          await rootBundle.load(join('assets', 'db', 'busycards_1.4.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Запись и очистка записанных байтов
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  //Возращает конкретную таблицу карточек(Животные или Птицы ...)
  static Future<List<BabyCard>> getListBabyCards(int id) async {
    String nameTable = getNameTable(id);
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM $nameTable;');
    // List<BabyCard> list =
    //     maps.isNotEmpty ? maps.map((e) => BabyCard.fromMap(e)).toList() : [];

    // return list;
    return [];
  }

  //Меню карточек
  // static Future<List<Menu>> getListMenuCards() async {
  //   final db = await database;
  //   var maps = await db.rawQuery('SELECT* FROM ${Table.menu};');
  //   List<Menu> list =
  //       maps.isNotEmpty ? maps.map((e) => Menu.fromMap(e)).toList() : [];
  //   return list;
  // }

  static Future<List<CategoryCardModel>> getListCategoryCards() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM ${Table.menu};');
    List<CategoryCardModel> list = maps.isNotEmpty
        ? maps.map((e) => CategoryCardModel.fromMap(e)).toList()
        : [];
    return list;
  }

  // Возращает name таблицы
  static String getNameTable(int id) {
    late String nameTable;

    switch (id) {
      case 0:
        nameTable = Table.table0;
        break;
      case 1:
        nameTable = Table.table1;
        break;
      case 2:
        nameTable = Table.table2;
        break;
      case 3:
        nameTable = Table.table3;
        break;
      case 4:
        nameTable = Table.table4;
        break;
      case 5:
        nameTable = Table.table5;
        break;
      case 6:
        nameTable = Table.table6;
        break;
      case 7:
        nameTable = Table.table7;
        break;
      case 8:
        nameTable = Table.table8;
        break;
      case 9:
        nameTable = Table.table9;
        break;
      case 10:
        nameTable = Table.table10;
        break;
      case 11:
        nameTable = Table.table11;
        break;
      case 12:
        nameTable = Table.table12;
        break;
      case 13:
        nameTable = Table.table13;
        break;
      case 14:
        nameTable = Table.table14;
        break;
      case 15:
        nameTable = Table.table15;
        break;
      case 16:
        nameTable = Table.table16;
        break;
      case 17:
        nameTable = Table.table17;
        break;
      case 18:
        nameTable = Table.table18;
        break;
      case 19:
        nameTable = Table.table19;
        break;
      case 20:
        nameTable = Table.table20;
        break;
      case 21:
        nameTable = Table.table21;
        break;
      case 22:
        nameTable = Table.table22;
        break;
      default:
        nameTable = Table.table0;
        break;
    }
    return nameTable;
  }
}

abstract class Table {
  static const table0 = 'table0';
  static const table1 = 'table1';
  static const table2 = 'table2';
  static const table3 = 'table3';
  static const table4 = 'table4';
  static const table5 = 'table5';
  static const table6 = 'table6';
  static const table7 = 'table7';
  static const table8 = 'table8';
  static const table9 = 'table9';
  static const table10 = 'table10';
  static const table11 = 'table11';
  static const table12 = 'table12';
  static const table13 = 'table13';
  static const table14 = 'table14';
  static const table15 = 'table15';
  static const table16 = 'table16';
  static const table17 = 'table17';
  static const table18 = 'table18';
  static const table19 = 'table19';
  static const table20 = 'table20';
  static const table21 = 'table21';
  static const table22 = 'table22';
  static const menu = 'menu';
}
