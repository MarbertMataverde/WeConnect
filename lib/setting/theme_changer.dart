import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  static bool _isLight = true;

  ThemeMode currentTheme() {
    return _isLight ? ThemeMode.light : ThemeMode.dark;
  }

  void switchTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _isLight = !_isLight;
    notifyListeners();
    await sp.setBool('theme', _isLight);
  }
}
