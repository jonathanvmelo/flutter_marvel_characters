// 3. Criação do ThemeData
import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/shared/themes/color_scheme.dart';
import 'package:flutter_marvel_characters/src/shared/themes/marvel_colors.dart';

final ThemeData marvelTheme = ThemeData(
  colorScheme: marvelColorScheme,
  scaffoldBackgroundColor: marvelColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: marvelColorScheme.background,
    foregroundColor: marvelColorScheme.onBackground,
    elevation: 0,
    centerTitle: true,
  ),
  inputDecorationTheme: InputDecorationTheme(    
    hintStyle: TextStyle(color: marvelColorScheme.secondary),
    border: const UnderlineInputBorder(
        borderSide: BorderSide(color: MarvelColors.accentGray)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: marvelColorScheme.secondary, width: 2.0)),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: marvelColorScheme.onBackground,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      color: marvelColorScheme.onBackground,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: marvelColorScheme.onBackground.withOpacity(0.9),
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      color: marvelColorScheme.onBackground,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  ),
);
