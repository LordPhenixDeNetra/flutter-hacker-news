import 'package:dynamic_theme_mode/dynamic_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:n_hacker_news/Screens/HomePage.dart';
import 'package:n_hacker_news/services/ThemeProvider.dart';
import 'package:n_hacker_news/themes/NTheme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DynamicThemeMode(
      initialThemeMode: themeProvider.themeMode,
      builder: (BuildContext contains, ThemeMode themeMode){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            /// ThemeData lightTheme du package:n_hacker_news/themes/NTheme.dart
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
        );
      }
    );
  }
}

