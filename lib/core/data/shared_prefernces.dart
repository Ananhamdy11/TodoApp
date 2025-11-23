import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences prefs;
  static const themeModeKey = 'THEME_MODE';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool getThemeIsDark() {
    return prefs.getBool(themeModeKey) ?? false;
  }

  Future<void> saveThemeIsDark(bool isDark) async {
    await prefs.setBool(themeModeKey, isDark);
  }
}
