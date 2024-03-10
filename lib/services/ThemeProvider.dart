import 'package:flutter/material.dart';
import 'package:n_hacker_news/themes/NTheme.dart';

class ThemeProvider extends ChangeNotifier {
/*
  ThemeData _themeData = lightTheme;

  ThemeMode themeMode = ThemeMode.system;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){

    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }

  void toggleThemeMode(){
    if (themeMode == ThemeMode.light) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
    notifyListeners();
  }

*/


// final IconData icon;

ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark; // Changer entre le thème sombre et le thème clair
    notifyListeners();
  }
  
}