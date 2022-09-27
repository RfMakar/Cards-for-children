import 'package:busycards/screen/game_find_couple/screen_game_find_couple.dart';
import 'package:busycards/screen/game_memory/screen_game_memory.dart';
import 'package:busycards/screen/game_where/sreen_game_where.dart';
import 'package:busycards/screen/widget/button_navigator_back.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';

class ScreenGame extends StatelessWidget {
  const ScreenGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ButtonNavigatorGame(
                name: 'Покажи карточку',
                pathIcon: 'assets/busycard/game/image/icongamewhere.png',
                screen: ScreenGameWhere(),
              ),
              ButtonNavigatorGame(
                name: 'Найди пару',
                pathIcon: 'assets/busycard/game/image/icongamefindcouple.png',
                screen: ScreenGameFindCouple(),
              ),
              ButtonNavigatorGame(
                name: 'Память',
                pathIcon: 'assets/busycard/game/image/icongamememory.png',
                screen: ScreenGameMemory(),
              ),
            ],
          ),
          Column(
            verticalDirection: VerticalDirection.up,
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ButtonNavigatorBack(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonNavigatorGame extends StatelessWidget {
  const ButtonNavigatorGame(
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
    return SizedBox(
      height: 180,
      width: 160,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(pathIcon),
              ),
              Center(child: Text(name, style: StyleWidget.textStyleGameMenu)),
            ],
          ),
        ),
      ),
    );
  }
}
