import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class AppDataModel with ChangeNotifier {
  final String _someData = '';
  AppThemeMode _themeMode = AppThemeMode.light; // Default to light theme

  String get getSome => _someData;
  AppThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    notifyListeners();
  }
}
