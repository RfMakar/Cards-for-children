import 'package:busycards/screen/widget/button_navigator_back.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ListView(
            children: [
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'О приложении',
                  style: GoogleFonts.lobster(fontSize: 20),
                )
              ]),
              ListTile(
                title: Text(
                  'Версия',
                  style: GoogleFonts.lobster(fontSize: 15),
                ),
                trailing: Text(
                  '2.0.2',
                  style: GoogleFonts.lobster(),
                ),
                onTap: null,
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Оставить отзыв',
                  style: GoogleFonts.lobster(fontSize: 15),
                ),
                onTap: () async {
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
                title: Text(
                  'Политика конфиденциальности',
                  style: GoogleFonts.lobster(fontSize: 15),
                ),
                onTap: () async {
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
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [ButtonNavigatorBack()],
            ),
          ),
        ],
      ),
    );
  }
}
