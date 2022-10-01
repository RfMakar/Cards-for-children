import 'package:busycards/screen/settings/screen_settings.dart';
import 'package:busycards/screen/widget/style_app.dart';
import 'package:flutter/material.dart';

class ButtonNavigatorSetting extends StatelessWidget {
  const ButtonNavigatorSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleWidget.styleIconButton,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenSettings()),
        );
      },
      child: const Icon(Icons.info_outline),
    );
  }
}
