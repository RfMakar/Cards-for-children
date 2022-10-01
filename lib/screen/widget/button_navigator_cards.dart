import 'package:busycards/data/db_menu_cards.dart';
import 'package:busycards/model/menu_cards.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';

//Кнопка вызова меню категорий карточек
class ButtonNavigatorCards extends StatelessWidget {
  const ButtonNavigatorCards({Key? key, required this.updatePage})
      : super(key: key);
  final Widget updatePage;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleWidget.styleIconButton,
      onPressed: () async {
        navigator() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => updatePage,
              ),
            );
        bool? click = await showModalBottomSheet(
          context: context,
          builder: (context) => const ListBabyCards(),
        );
        if (click != null) {
          navigator();
        }
      },
      child: const Icon(
        Icons.menu,
      ),
    );
  }
}

class ListBabyCards extends StatelessWidget {
  const ListBabyCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<MenuCards>>(
          future: DBMenuCards.getListMenu(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            final listMenuCards = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(4, 40, 4, 4),
              shrinkWrap: true,
              itemCount: listMenuCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return IconButtonCard(
                  menuCards: listMenuCards[index],
                );
              },
            );
          },
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
          child: Center(
              child: Text('Категории', style: StyleWidget.textStyleMenu)),
        ),
      ],
    );
  }
}

class IconButtonCard extends StatelessWidget {
  const IconButtonCard({Key? key, required this.menuCards}) : super(key: key);
  final MenuCards menuCards;
  @override
  Widget build(BuildContext context) {
    return menuCards.click == 1 ? clickTrue() : clickFalse(context);
  }

  Widget clickTrue() {
    return IconButton(
      onPressed: null,
      icon: Image.asset(menuCards.iconbutton),
    );
  }

  Widget clickFalse(BuildContext context) {
    return Card(
      child: IconButton(
        icon: Image.asset(menuCards.iconbutton),
        onPressed: () async {
          navigator() => Navigator.pop(context, true);
          var listClick = List.filled(13, 0);
          final index = menuCards.id;
          listClick[index] = 1;
          await DBMenuCards.updateMenu(listClick);
          navigator();
        },
      ),
    );
  }
}
