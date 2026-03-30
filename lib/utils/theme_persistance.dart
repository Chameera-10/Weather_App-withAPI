import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistance {
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isDark", isDark);
    print('Theme Stored');
  }

  Future<bool> loadTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('Theme loaded');
    return pref.getBool('isDark') ?? false;
  }
}
