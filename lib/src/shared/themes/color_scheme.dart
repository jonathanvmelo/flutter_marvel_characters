import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/shared/themes/marvel_colors.dart';

final ColorScheme marvelColorScheme = const ColorScheme.light(
  primary: MarvelColors.marvelRed,
  onPrimary: MarvelColors.onPrimary,
  secondary: MarvelColors.accentGray,
  onSecondary: MarvelColors.onBackground,
  surface: MarvelColors.lightSurface,
  onSurface: MarvelColors.onBackground,
  background: MarvelColors.lightBackground,
  onBackground: MarvelColors.onBackground,
  error: Color(0xFFCF6679),
  onError: Colors.white,
  brightness: Brightness.light,
);
