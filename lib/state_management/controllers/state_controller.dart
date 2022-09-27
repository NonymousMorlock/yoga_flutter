import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class StateController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  int _currentIndex = 1;
  int _previousIndex = 1;

  int get currentIndex => _currentIndex;
  int get previousIndex => _previousIndex;

  SharedPreferences? prefs;
  final Map<ThemeMode, String> _fromThemes = {
    ThemeMode.dark: "system",
    ThemeMode.light: "light",
    ThemeMode.system: "system",
  };
  final Map<String, ThemeMode> _toThemes = {
    "system": ThemeMode.system,
    "light": ThemeMode.light,
    "dark": ThemeMode.dark,
  };

  void changeTheme(ThemeMode theme) async{
    _themeMode = theme;
    await saveTheme();
    notifyListeners();
  }

  void initPrefs(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  Future<void> saveTheme() async {
    await prefs!.setString(kThemeKey, _fromThemes[_themeMode]!);
  }
  void getTheme() {
    final themeName = prefs!.getString(kThemeKey);
    if(themeName != null) _themeMode = _toThemes[themeName]!;
  }

  void changeIndex(int idx) {
    _previousIndex = _currentIndex;
    _currentIndex = idx;
    notifyListeners();
  }

}