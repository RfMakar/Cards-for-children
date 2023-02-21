import 'package:busycards/data/db_menu.dart';
import 'package:busycards/data/sp_counter_run_app.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/cards/screen_menu_cards.dart';
import 'package:busycards/screen/game/screen_menu_game.dart';
import 'package:busycards/screen/info/screen_menu_info.dart';
import 'package:busycards/screen/raw/screen_raw.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenMenuHome extends StatelessWidget {
  const ScreenMenuHome({Key? key}) : super(key: key);
  //Запуск счетчика на отзыв
  void runCounterFeedback(BuildContext context) async {
    var boolRunCounter = await SharPrefCounterRunApp.getBoolRunCounter();
    /*Если счетчик считает, то счетчик увеличивается на 1, 
     если приложение запускается 10 или 30 раз то откроется шторка на отзыв,
     если приложение запускается больше 30 раз то счетчик останавливается;
    */
    if (boolRunCounter) {
      SharPrefCounterRunApp.incrementCounter();
      var runCounter = await SharPrefCounterRunApp.getIntRunCounter();

      if (runCounter == 10 || runCounter == 30) {
        showModalBottomSheet(
            context: context,
            builder: (context) => const WidgetSheetFeedback());
      } else if (runCounter > 30) {
        SharPrefCounterRunApp.setStopBoolRunCounter();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    runCounterFeedback(context);

    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          children: [
            Image.asset('assets/icon/0.png', height: 40, width: 40),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Idea', style: TextApp.secondary),
                  TextSpan(text: ' ', style: TextApp.secondary),
                  TextSpan(text: 'Might', style: TextApp.golden),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorsApp.secondary,
      body: const ListMenuHome(),
    );
  }
}

class ListMenuHome extends StatelessWidget {
  const ListMenuHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Menu>>(
      future: DBMenu.getListMenuHome(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listMenuHome = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              WidgetMenuCard(menu: listMenuHome[0], color: ColorsApp.menuCards),
              WidgetMenuCard(menu: listMenuHome[1], color: ColorsApp.menuGame),
              WidgetMenuCard(menu: listMenuHome[2], color: ColorsApp.menuRaw),
              WidgetMenuCard(menu: listMenuHome[3], color: ColorsApp.menuInfo),
            ],
          ),
        );
      },
    );
  }
}

class WidgetMenuCard extends StatelessWidget {
  const WidgetMenuCard({Key? key, required this.menu, required this.color})
      : super(key: key);
  final Menu menu;
  final Color color;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      if (menu.id == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenMenuCards(
                    menu: menu,
                  )),
        );
      } else if (menu.id == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScreenMenuGame(menu: menu)),
        );
      } else if (menu.id == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScreenRaw(menu: menu)),
        );
      } else if (menu.id == 3) {
        showModalBottomSheet(
          context: context,
          builder: (context) => const ScreenMenuInfo(),
        );
      }
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: color,
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

/*
~~Виджет нижняя шторка отзыва~~
Если нажать кнопку да(оставить отзыв) то счетчик остановиться, приложение
перейдеи на страницу магазина.
Если нажать нет то закроется шторка
*/
class WidgetSheetFeedback extends StatelessWidget {
  const WidgetSheetFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: ColorsApp.golden,
          ),
          height: 40,
          child: Center(child: Text('Оставить отзыв?', style: TextApp.appBar)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                Navigator.pop(context);
                SharPrefCounterRunApp.setStopBoolRunCounter();
                final Uri url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.dom.busycards');

                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $url';
                }
              },
              child: Text('Да', style: TextApp.appBar),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: Text('Нет', style: TextApp.appBar),
            )
          ],
        )
      ],
    );
  }
}
