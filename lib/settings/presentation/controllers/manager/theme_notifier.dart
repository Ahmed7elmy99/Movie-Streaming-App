import 'package:flutter/material.dart';
import 'package:movie_app/settings/presentation/controllers/manager/theme_data_base.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    _loadThemeFromDatabase();
  }

  void _loadThemeFromDatabase() async {
    String? savedTheme = await ThemeDatabase().getTheme();
    if (savedTheme != null) {
      if (savedTheme == "light") {
        _themeMode = ThemeMode.light;
      } else if (savedTheme == "dark") {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
    }
    notifyListeners();
  }

  void toggleTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();

    String themeString = themeMode == ThemeMode.light
        ? 'light'
        : themeMode == ThemeMode.dark
            ? 'dark'
            : 'system';

    await ThemeDatabase().insertTheme(themeString);
  }
}
