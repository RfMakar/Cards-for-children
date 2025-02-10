import 'package:busycards/core/constants/key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageLocalService {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  //audio_background
  Future<bool> getAudioBackground() async {
    final isRes = await _prefs.getBool(keyAudioPlayerBackground);
    if (isRes == null) {
      await setAudioBackground(false);
      return false;
    } else {
      return isRes;
    }
  }

  Future<void> setAudioBackground(bool value) async {
    await _prefs.setBool(keyAudioPlayerBackground, value);
  }
}
