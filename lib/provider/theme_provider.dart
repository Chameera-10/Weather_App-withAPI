import 'package:flutter/material.dart';
import 'package:weather_app/utils/theme_persistance.dart';
import 'package:weather_app/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadTheme();
  }

  ThemeData _themeData = ThemesModeData().lightMode;

  final ThemePersistance _themePersistance = ThemePersistance();

  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  ThemeData get getThemeData => _themeData;

  Future<void> _loadTheme() async {
    bool isDark = await _themePersistance.loadTheme();
    setThemeData = isDark
        ? ThemesModeData().darkMode
        : ThemesModeData().lightMode;
  }

  Future<void> toggleTheme(bool isDark) async {
    setThemeData = isDark
        ? ThemesModeData().darkMode
        : ThemesModeData().lightMode;
    await _themePersistance.storeTheme(isDark);
    notifyListeners();
  }
}
