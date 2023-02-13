import 'package:busycards/data/db_raw.dart';
import 'package:busycards/model/raw.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderScreenRaw extends ChangeNotifier {
  var idTable = 0; //Номер таблицы
  final audioPlayer = AudioPlayer();
  var color = ColorsApp.menuRaw; //Цвет кнопки

  //Нажатие кнопки(воспроизводит звук)
  void onPressedButtonRaw(Raw raw) async {
    await audioPlayer.setAsset(raw.raw);
    audioPlayer.play();
  }

  //Меняет цвет кнопки
  void colorRaw() {
    if (idTable == 0) {
      color = ColorsApp.menuRaw;
    } else if (idTable == 1) {
      color = const Color.fromRGBO(255, 241, 82, 1);
    } else if (idTable == 2) {
      color = const Color.fromRGBO(255, 82, 82, 1);
    } else if (idTable == 3) {
      color = const Color.fromRGBO(252, 82, 255, 1);
    } else if (idTable == 4) {
      color = const Color.fromRGBO(82, 151, 255, 1);
    }
  }

  //Нажатие кнопки перезегрузки звуков
  void onPressedButtomSync() {
    if (idTable == 4) {
      idTable = 0;
      notifyListeners();
    } else {
      idTable++;
      notifyListeners();
    }
    audioPlayer.stop();
    colorRaw();
  }

  Future<List<Raw>> getListRaw() => DBRaw.getListRaw(idTable);

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
