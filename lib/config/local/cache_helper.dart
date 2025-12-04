
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setData({
    required String key,
    required String value,
  }) async {
    await _prefs.setString(key, value);
  }

  static String? getData({required String key}) {
    return _prefs.getString(key);
  }

  static Future<void> removeData({required String key}) async {
    await _prefs.remove(key);
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }

}
