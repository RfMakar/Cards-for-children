import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenMenuInfo extends StatelessWidget {
  const ScreenMenuInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: ColorsApp.menuInfo,
          ),
          height: 50,
          child: Center(child: Text('Инфо', style: TextApp.appBar)),
        ),
        const CardInfo(
          title: 'Версия 2.0.4',
          onTap: null,
        ),
        CardInfo(
            title: 'Оставить отзыв',
            onTap: () async {
              Navigator.pop(context);
              final Uri url = Uri.parse(
                  'https://play.google.com/store/apps/details?id=com.dom.busycards');

              if (!await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Could not launch $url';
              }
            }),
        CardInfo(
            title: 'Политика конфиденциальности',
            onTap: () async {
              Navigator.pop(context);
              final Uri url = Uri.parse(
                  'https://sites.google.com/view/ideamight/busycard/privacypolicy');

              if (!await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Could not launch $url';
              }
            }),
      ],
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(
              title,
              style: TextApp.back,
            )),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
