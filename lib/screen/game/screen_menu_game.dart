import 'package:busycards/data/db_menu.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/game/alphabet/screen_alphabet_game.dart';
import 'package:busycards/screen/game/find_couple/screen_find_couple_game.dart';
import 'package:busycards/screen/game/memory/screen_memory_game.dart';
import 'package:busycards/screen/game/quiz/sreen_quiz_game.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';

class ScreenMenuGame extends StatelessWidget {
  const ScreenMenuGame({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name, style: TextApp.appBar),
        backgroundColor: ColorsApp.menuGame,
      ),
      backgroundColor: ColorsApp.backgroundMenuGame,
      body: const ListMenuGame(),
    );
  }
}

class ListMenuGame extends StatelessWidget {
  const ListMenuGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Menu>>(
      future: DBMenu.getListMenuGame(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listMenuGame = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              WidgetMenuCard(menu: listMenuGame[0]),
              WidgetMenuCard(menu: listMenuGame[1]),
              WidgetMenuCard(menu: listMenuGame[2]),
              WidgetMenuCard(menu: listMenuGame[3]),
            ],
          ),
        );
      },
    );
  }
}

class WidgetMenuCard extends StatelessWidget {
  const WidgetMenuCard({Key? key, required this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      if (menu.id == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenQuizGame()),
        );
      } else if (menu.id == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFindCoupleGame()),
        );
      } else if (menu.id == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenMemoryGame()),
        );
      } else if (menu.id == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenAlphabetGame()),
        );
      }
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: ColorsApp.menuGame,
          child: Row(
            children: [
              Image.asset(menu.icon, width: 120, height: 120),
              Text(menu.name, softWrap: true, style: TextApp.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
