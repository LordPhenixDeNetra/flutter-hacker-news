// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:n_hacker_news/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: lightBackgroud,
      primary: lightPrimary,
      secondary: lightSecondary,
      tertiary: lightCamera,
      surface: lightHeader,
  ),
  // iconTheme: IconThemeData(color: Colors.white),

  // primarySwatch: Colors.deepOrange,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: darkBackgroud,
      primary: darkPrimary,
      secondary: darkSecondary,
      tertiary: darkCamera,
      surface: darkHeader,
  ),
  iconTheme: IconThemeData(color: Colors.white),

  // primarySwatch: Colors.yellow,
);


/*
// Définition d'un nouvel objet ColorScheme avec les couleurs spécifiées
ColorScheme colorScheme = ColorScheme(
  // Couleur principale de l'application
  primary: Colors.blue,
  // Variante de la couleur principale (utilisée pour des éléments comme les barres de progression)
  primaryVariant: Colors.blue[700],
  // Couleur secondaire de l'application
  secondary: Colors.green,
  // Variante de la couleur secondaire (utilisée pour des éléments comme les barres de progression)
  secondaryVariant: Colors.green[700],
  // Couleur de surface de l'application (utilisée pour les surfaces telles que les cartes, les boîtes de dialogue, etc.)
  surface: Colors.white,
  // Couleur de fond de l'application
  background: Colors.grey[200],
  // Couleur utilisée pour indiquer les erreurs
  error: Colors.red,
  // Couleur de texte appropriée pour être utilisée sur la couleur principale
  onPrimary: Colors.white,
  // Couleur de texte appropriée pour être utilisée sur la couleur secondaire
  onSecondary: Colors.white,
  // Couleur de texte appropriée pour être utilisée sur la couleur de surface
  onSurface: Colors.black,
  // Couleur de texte appropriée pour être utilisée sur la couleur de fond
  onBackground: Colors.black,
  // Couleur de texte appropriée pour être utilisée sur la couleur d'erreur
  onError: Colors.white,
);
*/
