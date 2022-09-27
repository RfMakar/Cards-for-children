import 'package:busycards/model/menu_cards.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBMenuCards {
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'card.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE menu(
          name TEXT,
          id INTEGER,
          iconbutton TEXT,
          click INTEGER
          );
      ''');
    await db.rawInsert('''
          INSERT INTO menu(name, id, iconbutton, click) VALUES
          ('menuanimals', 0, 'assets/busycard/menu/menuanimals.png', 1),
          ('menufruitsandvegetables', 1, 'assets/busycard/menu/menufruitsandvegetables.png', 0),
          ('menutransport', 2, 'assets/busycard/menu/menutransport.png', 0),
          ('menustreet', 3, 'assets/busycard/menu/menustreet.png', 0),
          ('menufood', 4, 'assets/busycard/menu/menufood.png', 0),
          ('menuelectronics', 5, 'assets/busycard/menu/menuelectronics.png', 0),
          ('menuhome', 6, 'assets/busycard/menu/menuhome.png', 0),
          ('menuclothes', 7, 'assets/busycard/menu/menuclothes.png', 0),
          ('menuhuman', 8, 'assets/busycard/menu/menuhuman.png', 0),
          ('menuletters', 9, 'assets/busycard/menu/menuletters.png', 0),
          ('menufigures', 10, 'assets/busycard/menu/menufigures.png', 0),
          ('menucolors', 11, 'assets/busycard/menu/menucolors.png', 0),
          ('menunumbers', 12, 'assets/busycard/menu/menunumbers.png', 0);
         
''');
  }

  static Future<void> updateMenu(List<int> list) async {
    final db = await database;
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 0;', [list[0]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 1;', [list[1]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 2;', [list[2]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 3;', [list[3]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 4;', [list[4]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 5;', [list[5]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 6;', [list[6]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 7;', [list[7]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 8;', [list[8]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 9;', [list[9]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 10;', [list[10]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 11;', [list[11]]);
    await db.rawUpdate('UPDATE menu SET click = ? WHERE id = 12;', [list[12]]);
  }

  static Future<int> idMenuTable() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM menu;');
    var id = 0;
    List<MenuCards> list =
        maps.isNotEmpty ? maps.map((e) => MenuCards.fromMap(e)).toList() : [];
    for (var menuCards in list) {
      if (menuCards.click == 1) {
        id = menuCards.id;
      }
    }
    return id;
  }

  static Future<List<MenuCards>> getListMenu() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM menu;');
    List<MenuCards> list =
        maps.isNotEmpty ? maps.map((e) => MenuCards.fromMap(e)).toList() : [];
    return list;
  }
}
