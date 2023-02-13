import 'dart:io';
import 'package:busycards/model/raw.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBRaw {
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'raw_1.3.db');

    var exists = await databaseExists(path);
    if (!exists) {
      //Если БД не существует то копируем из ресурсов
      ByteData data = await rootBundle.load(join('assets', 'db', 'raw_1.3.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Запись и очистка записанных байтов
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  //Возращает конкретную таблицу звуков
  static Future<List<Raw>> getListRaw(int id) async {
    String nameTable = getNameTable(id);
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM $nameTable;');
    List<Raw> list =
        maps.isNotEmpty ? maps.map((e) => Raw.fromMap(e)).toList() : [];

    return list;
  }

  // Возращает name таблицы
  static String getNameTable(int id) {
    late String nameTable;

    switch (id) {
      case 0:
        nameTable = Table.raw0;
        break;
      case 1:
        nameTable = Table.raw1;
        break;
      case 2:
        nameTable = Table.raw2;
        break;
      case 3:
        nameTable = Table.raw3;
        break;
      case 4:
        nameTable = Table.raw4;
        break;

      default:
        nameTable = Table.raw0;
        break;
    }
    return nameTable;
  }
}

abstract class Table {
  static const raw0 = 'raw0';
  static const raw1 = 'raw1';
  static const raw2 = 'raw2';
  static const raw3 = 'raw3';
  static const raw4 = 'raw4';
}
