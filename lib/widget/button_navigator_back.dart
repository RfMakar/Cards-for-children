import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';

class ButtonNavigatorBack extends StatelessWidget {
  const ButtonNavigatorBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleWidget.styleIconButton,
      onPressed: () => Navigator.pop(context),
      child: const Icon(Icons.navigate_before),
    );
  }
}
