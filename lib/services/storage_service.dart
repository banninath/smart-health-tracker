import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  // Optional: You can also later save goals and appointments lists here if needed.
}
