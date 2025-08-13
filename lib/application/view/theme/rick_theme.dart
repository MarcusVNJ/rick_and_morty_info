import 'package:flutter/material.dart';
import 'rick_colors.dart';

class RickTheme {
  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'PublicSans',

      primaryColor: RickColors.primary,
      scaffoldBackgroundColor: RickColors.background,

      colorScheme: const ColorScheme.dark(
        primary: RickColors.primary,
        secondary: RickColors.primary,
        surface: RickColors.cardBackground,
        onPrimary: RickColors.black,
        onSurface: RickColors.textPrimary,
      ),

      cardTheme: CardThemeData(
        color: RickColors.cardBackground,
        elevation: 4,
        shadowColor: RickColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: RickColors.textPrimary, fontSize: 16),
        titleLarge: TextStyle(color: RickColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 22),
        titleMedium: TextStyle(color: RickColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: RickColors.cardBackground,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontFamily: 'PublicSans',
          color: RickColors.primary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}