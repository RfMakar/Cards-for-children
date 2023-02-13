import 'dart:io';
import 'package:busycards/model/menu.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBMenu {
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'menu_1.3.db');

    var exists = await databaseExists(path);
    if (!exists) {
      //Если БД не существует то копируем из ресурсов
      ByteData data =
          await rootBundle.load(join('assets', 'db', 'menu_1.3.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Запись и очистка записанных байтов
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  //Начальное меню
  static Future<List<Menu>> getListMenuHome() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM ${Table.home};');
    List<Menu> list =
        maps.isNotEmpty ? maps.map((e) => Menu.fromMap(e)).toList() : [];
    return list;
  }

  //Меню карточек
  static Future<List<Menu>> getListMenuCards() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM ${Table.cards};');
    List<Menu> list =
        maps.isNotEmpty ? maps.map((e) => Menu.fromMap(e)).toList() : [];
    return list;
  }

  //Меню игр
  static Future<List<Menu>> getListMenuGame() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM ${Table.game};');
    List<Menu> list =
        maps.isNotEmpty ? maps.map((e) => Menu.fromMap(e)).toList() : [];
    return list;
  }

  //Меню категорий карточек для игр
  static Future<List<Menu>> getListCategoryCardsGame() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM ${Table.cards};');
    List<Menu> list =
        maps.isNotEmpty ? maps.map((e) => Menu.fromMap(e)).toList() : [];

    if (list.isNotEmpty) {
      list.removeWhere((element) => element.id == 13);
      list.removeWhere((element) => element.id == 16);
      list.removeWhere((element) => element.id == 17);
    }
    return list;
  }
}

abstract class Table {
  static const home = 'home';
  static const cards = 'cards';
  static const game = 'game';
}
