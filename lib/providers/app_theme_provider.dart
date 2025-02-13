import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  // data
  ThemeMode appThemeMode = ThemeMode.light;

  void changeThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == appThemeMode) {
      return;
    }
    appThemeMode = newThemeMode;
    notifyListeners();
  }
}
