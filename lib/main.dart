// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:n_hacker_news/App.dart';
import 'package:n_hacker_news/Database/DatabaseHelper.dart';
import 'package:n_hacker_news/services/AnimationProvider.dart';
import 'package:n_hacker_news/services/DatabaseHelperProvider.dart';
import 'package:n_hacker_news/services/NewsProvider.dart';
import 'package:n_hacker_news/services/ThemeProvider.dart';
import 'package:provider/provider.dart';

void main() {

  // DatabaseHelper databaseHelper = DatabaseHelper();

  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(
          create: (_) => NewsProvider(), // Replace AudioProvider() with your actual provider instantiation logic
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(), // Remplacez OtherProvider() par votre logique d'instanciation réelle de OtherProvider
        ),
        ChangeNotifierProvider<AnimationProvider>(
          create: (_) => AnimationProvider(), // Remplacez OtherProvider() par votre logique d'instanciation réelle de OtherProvider
        ),

        ChangeNotifierProvider<DatabaseHelperProvider>(
          create: (_) => DatabaseHelperProvider(), // Remplacez OtherProvider() par votre logique d'instanciation réelle de OtherProvider
        ),
      ],
      child: App(),
    ),);
}



