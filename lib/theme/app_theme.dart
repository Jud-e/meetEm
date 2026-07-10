import 'package:flutter/material.dart';

/// Colors pulled directly from the Figma palette export.
class AppColors {
  // Teal ramp — used as the accent in dark mode
  static const teal50 = Color(0xFFB0DFF6);
  static const teal100 = Color(0xFF5DBCE0);
  static const teal200 = Color(0xFF4894B1); // primary dark-mode accent
  static const teal300 = Color(0xFF346E84);
  static const teal400 = Color(0xFF214A5A);
  static const teal500 = Color(0xFF0F2932);
  static const teal600 = Color(0xFF051319);

  // Indigo ramp — used as the accent in light mode
  static const indigo50 = Color(0xFFEFF0FE);
  static const indigo100 = Color(0xFFCCD0FD);
  static const indigo200 = Color(0xFF9CA5FC);
  static const indigo300 = Color(0xFF697AFA);
  static const indigo400 = Color(0xFF1E4DF7);
  static const indigo500 = Color(0xFF0E31AA); // primary light-mode accent
  static const indigo600 = Color(0xFF041862);

  // Neutral ramp — text and borders
  static const neutral50 = Color(0xFFD6D8DA);
  static const neutral100 = Color(0xFFADB1B3);
  static const neutral200 = Color(0xFF888B8D);
  static const neutral300 = Color(0xFF656768);
  static const neutral400 = Color(0xFF434546);
  static const neutral500 = Color(0xFF242526);
  static const neutral600 = Color(0xFF101111);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: AppColors.indigo500,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: AppColors.neutral500,
          secondary: AppColors.indigo300,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.neutral500,
          elevation: 0,
        ),
        textTheme: _textTheme(AppColors.neutral500, AppColors.neutral300),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.indigo500,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            side: const BorderSide(color: AppColors.neutral50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            foregroundColor: AppColors.neutral500,
          ),
        ),
        inputDecorationTheme: _inputTheme(
          fillColor: AppColors.indigo50,
          borderColor: AppColors.neutral50,
          hintColor: AppColors.neutral200,
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.teal600,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.teal200,
          onPrimary: Colors.white,
          surface: AppColors.teal500,
          onSurface: Colors.white,
          secondary: AppColors.teal100,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.teal600,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: _textTheme(Colors.white, AppColors.neutral100),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal200,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            side: const BorderSide(color: AppColors.teal400),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: _inputTheme(
          fillColor: AppColors.teal500,
          borderColor: AppColors.teal400,
          hintColor: AppColors.neutral200,
        ),
      );

  static TextTheme _textTheme(Color primary, Color secondary) => TextTheme(
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: primary, height: 1.2),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
        bodyMedium: TextStyle(fontSize: 14, color: secondary, height: 1.4),
        labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: secondary),
      );

  static InputDecorationTheme _inputTheme({
    required Color fillColor,
    required Color borderColor,
    required Color hintColor,
  }) =>
      InputDecorationTheme(
        filled: true,
        fillColor: fillColor,
        hintStyle: TextStyle(color: hintColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
      );
}