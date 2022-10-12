import 'package:shared_preferences/shared_preferences.dart';

//Счетчик количества запуска приложения
abstract class SharPrefCounterRunApp {
  //Открывает данные
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  //true - счетчик считает количество запусков
  //false - счетчик не считает количество запусков
  static Future<bool> getBoolRunCounter() async {
    var pref = await prefs;
    var counter = pref.getBool('runBoolCounter') ?? true;
    return counter;
  }

  //Останавливает подсчет запусков приложения
  static void setStopBoolRunCounter() async {
    var pref = await prefs;
    await pref.setBool('runBoolCounter', false);
  }

  //Увеличивает количество запусков на 1
  static void incrementCounter() async {
    var pref = await prefs;
    var counter = await getIntRunCounter() + 1;
    pref.setInt('runCounter', counter);
  }

  //Возращает количество запусков приложения
  static Future<int> getIntRunCounter() async {
    var pref = await prefs;
    var counter = pref.getInt('runCounter') ?? 0;
    return counter;
  }
}
