import 'package:flutter/material.dart';

class Menu {
  final int id;
  final String name;
  final String icon;
  final String audio;

  Menu(
      {required this.id,
      required this.name,
      required this.icon,
      required this.audio});

  Menu.start({
    this.id = 0,
    this.name = '',
    this.icon = '',
    this.audio = '',
  });

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        audio: json['audio'],
      );

  Color colorCard() {
    switch (id) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.brown;
      case 3:
        return Colors.indigo;
      case 4:
        return Colors.green;
      case 5:
        return Colors.lime;
      case 6:
        return Colors.orange;
      case 7:
        return Colors.pink;
      case 8:
        return Colors.purple;
      case 9:
        return Colors.yellow;
      case 10:
        return Colors.red;
      case 11:
        return Colors.black;
      case 12:
        return Colors.amberAccent;
      case 13:
        return Colors.blueGrey;
      case 14:
        return Colors.cyan;
      case 15:
        return Colors.deepOrange;
      case 16:
        return Colors.lightBlue;
      case 17:
        return Colors.orange;
      case 18:
        return Colors.lime;
      case 19:
        return Colors.green;
      case 20:
        return Colors.grey;
      case 21:
        return Colors.indigo;
      case 22:
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }
}
