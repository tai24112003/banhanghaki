import 'package:shared_preferences/shared_preferences.dart';

class Stored {
  static Future<dynamic> loadStoredText(String key) async {
    Object history = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history = prefs.get(key) ?? '';
    print(history);
    return history;
  }

  static Future<bool> saveText(String key, dynamic text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, text);
    return true;
  }
}
