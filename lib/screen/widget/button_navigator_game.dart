import 'package:busycards/screen/game_find_couple/screen_game_find_couple.dart';
import 'package:busycards/screen/game_memory/screen_game_memory.dart';
import 'package:busycards/screen/game_where/sreen_game_where.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';

//Кнопка вызова меню игр
class ButtonNavigatorGame extends StatelessWidget {
  const ButtonNavigatorGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleWidget.styleIconButton,
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => const ListGameCards(),
      ),
      child: const Icon(Icons.gamepad_outlined),
    );
  }
}

class ListGameCards extends StatelessWidget {
  const ListGameCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          mainAxisSpacing: 20,
          crossAxisCount: 3,
          padding: const EdgeInsets.fromLTRB(4, 40, 4, 4),
          children: const [
            ButtonGame(
              name: 'Покажи карточку',
              pathIcon: 'assets/busycard/game/image/icongamewhere.png',
              screen: ScreenGameWhere(),
            ),
            ButtonGame(
              name: 'Найди пару',
              pathIcon: 'assets/busycard/game/image/icongamefindcouple.png',
              screen: ScreenGameFindCouple(),
            ),
            ButtonGame(
              name: 'Память',
              pathIcon: 'assets/busycard/game/image/icongamememory.png',
              screen: ScreenGameMemory(),
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: ColorsApp.primary,
          ),
          height: 40,
          child: Center(child: Text('Игры', style: StyleWidget.textStyleMenu)),
        ),
      ],
    );
  }
}

class ButtonGame extends StatelessWidget {
  const ButtonGame(
      {Key? key,
      required this.screen,
      required this.name,
      required this.pathIcon})
      : super(key: key);
  final Widget screen;
  final String name;
  final String pathIcon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset(pathIcon),
            ),
          ),
          Center(child: Text(name, style: StyleWidget.textStyleGameMenu)),
        ],
      ),
    );
  }
}
