import 'package:shared_preferences/shared_preferences.dart';

class Stored {
  static Future<String> loadStoredText(String key) async {
    String history = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history = prefs.getString(key) ?? '';
    print(history);
    return history;
  }

  static Future<bool> saveText(String key, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, text);
    return true;
  }
}
