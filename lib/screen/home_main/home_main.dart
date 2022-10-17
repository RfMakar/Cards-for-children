import 'dart:async';
import 'package:busycards/data/sp_counter_run_app.dart';
import 'package:busycards/screen/baby_card/screen_baby_cards.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

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
    Timer(const Duration(seconds: 2), () async {
      runCounterFeedback(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenBabyCards()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextLiquidFill(
          loadDuration: const Duration(seconds: 1),
          text: 'Карточки для детей',
          textAlign: TextAlign.center,
          waveColor: ColorsApp.primary,
          boxBackgroundColor: Colors.white,
          textStyle: GoogleFonts.lobster(fontSize: 70),
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
            color: ColorsApp.primary,
          ),
          height: 40,
          child:
              Center(child: Text('Оставить отзыв?', style: TextApp.secondary)),
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
              child: Text('Да', style: TextApp.secondary),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Нет',
                style: TextApp.secondary,
              ),
            )
          ],
        )
      ],
    );
  }
}
