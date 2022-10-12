import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonNavigatorSetting extends StatelessWidget {
  const ButtonNavigatorSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleWidget.styleIconButton,
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => const ListSetting(),
      ),
      child: const Icon(Icons.info_outline),
    );
  }
}

class ListSetting extends StatelessWidget {
  const ListSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(4, 40, 4, 4),
          children: [
            ListTile(
              title: Text('Версия', style: TextApp.primary),
              trailing: Text('2.0.2', style: TextApp.primary),
              onTap: null,
            ),
            const Divider(),
            ListTile(
              title: Text('Оставить отзыв', style: TextApp.primary),
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
              },
            ),
            const Divider(),
            ListTile(
              title:
                  Text('Политика конфиденциальности', style: TextApp.primary),
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
              },
            ),
            const Divider(),
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
          child: Center(child: Text('О приложении', style: TextApp.secondary)),
        ),
      ],
    );
  }
}
