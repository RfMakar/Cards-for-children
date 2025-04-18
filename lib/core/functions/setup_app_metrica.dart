import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:busycards/core/constants/constants.dart';

Future<void> setupAppMetrica() async {
 await AppMetrica.activate(const AppMetricaConfig(keyAppMetrica));
  // AppMetrica.reportEvent('My first AppMetrica event!');
}
