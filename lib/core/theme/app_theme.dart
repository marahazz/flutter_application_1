import 'package:flutter/material.dart';

/// Material 3 theme for AUTONEXA.
/// Provides light and dark themes with a modern, professional palette.
class AppTheme {
  AppTheme._();

  /// Seed color: deep teal/cyan for a professional, automotive feel.
  static const Color _seedColor = Color(0xFF0D7377);

  static ThemeData get light {
    const white = Colors.white;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
        primary: const Color(0xFF0D7377),
        secondary: const Color(0xFF14A3A8),
        surface: white,
      ),
      scaffoldBackgroundColor: white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: white,
        foregroundColor: Colors.black,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: white,
      ),
      fontFamily: 'Roboto',
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
        primary: const Color(0xFF14A3A8),
        secondary: const Color(0xFF0D7377),
      ),
      scaffoldBackgroundColor: const Color(0xFF070A12),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: Color(0xFF070A12),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      fontFamily: 'Roboto',
    );
  }
}
