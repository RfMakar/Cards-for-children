import 'package:busycards/data/db_menu.dart';
import 'package:busycards/model/menu.dart';
import 'package:flutter/material.dart';
import '../../../widget/style_app.dart';

class ButtonMenuCategoryGame extends StatelessWidget {
  const ButtonMenuCategoryGame({Key? key, required this.onPressed})
      : super(key: key);
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: const StadiumBorder(
                side: BorderSide(color: ColorsApp.secondary, width: 2)),
            backgroundColor: ColorsApp.menuGame,
            onPressed: onPressed,
            child: const Icon(Icons.grid_on),
          ),
        ),
      ],
    );
  }
}

class ListCategoryGame extends StatelessWidget {
  const ListCategoryGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<Menu>>(
          future: DBMenu.getListCategoryCardsGame(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            final listMenuCards = snapshot.data!;
            return Container(
              color: ColorsApp.backgroundMenuGame,
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(4, 40, 4, 4),
                shrinkWrap: true,
                itemCount: listMenuCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return IconButtonCard(
                    menu: listMenuCards[index],
                  );
                },
              ),
            );
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: ColorsApp.menuGame,
          ),
          height: 40,
          child: Center(child: Text('Категории', style: TextApp.appBar)),
        ),
      ],
    );
  }
}

class IconButtonCard extends StatelessWidget {
  const IconButtonCard({Key? key, required this.menu}) : super(key: key);
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.menuGame,
      child: IconButton(
        icon: Image.asset(menu.icon),
        onPressed: () {
          Navigator.pop(context, menu.id);
        },
      ),
    );
  }
}
