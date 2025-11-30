// ============================================================================
// FILE: lib/utils/theme.dart (UPDATED)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============================================================================
  // DARK THEME COLORS
  // ============================================================================
  static const Color darkPrimaryBlack = Color(0xFF000000);
  static const Color darkBackgroundBlack = Color(0xFF0A0A0A);
  static const Color darkSurfaceGray = Color(0xFF1A1A1A);
  static const Color darkBorderGray = Color(0xFF2A2A2A);
  static const Color darkTextWhite = Color(0xFFFFFFFF);
  static const Color darkTextGray = Color(0xFFB0B0B0);
  static const Color darkAccentWhite = Color(0xFFFFFFFF);

  // ============================================================================
  // LIGHT THEME COLORS
  // ============================================================================
  static const Color lightPrimaryWhite = Color(0xFFFFFFFF);
  static const Color lightBackgroundWhite = Color(0xFFF5F5F5);
  static const Color lightSurfaceWhite = Color(0xFFFFFFFF);
  static const Color lightBorderGray = Color(0xFFE0E0E0);
  static const Color lightTextBlack = Color(0xFF000000);
  static const Color lightTextGray = Color(0xFF666666);
  static const Color lightAccentBlack = Color(0xFF000000);

  // ============================================================================
  // SHARED ACCENT COLORS (used in both themes)
  // ============================================================================
  static const Color accentBlue = Color(0xFF00D9FF);
  static const Color accentYellow = Color(0xFFFFD600);
  static const Color accentGreen = Color(0xFF00FF88);
  static const Color accentRed = Color(0xFFFF006E);
  static const Color accentOrange = Color(0xFFFF9500);

  // ============================================================================
  // DARK THEME
  // ============================================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackgroundBlack,

      colorScheme: const ColorScheme.dark(
        primary: darkAccentWhite,
        secondary: darkTextGray,
        surface: darkSurfaceGray,
        background: darkBackgroundBlack,
        onPrimary: darkPrimaryBlack,
        onSecondary: darkBackgroundBlack,
        onSurface: darkTextWhite,
        onBackground: darkTextWhite,
      ),

      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: const TextStyle(color: darkTextWhite),
        displayMedium: const TextStyle(color: darkTextWhite),
        displaySmall: const TextStyle(color: darkTextWhite),
        headlineLarge: const TextStyle(color: darkTextWhite),
        headlineMedium: const TextStyle(color: darkTextWhite),
        headlineSmall: const TextStyle(color: darkTextWhite),
        titleLarge: const TextStyle(color: darkTextWhite),
        titleMedium: const TextStyle(color: darkTextWhite),
        titleSmall: const TextStyle(color: darkTextWhite),
        bodyLarge: const TextStyle(color: darkTextWhite),
        bodyMedium: const TextStyle(color: darkTextWhite),
        bodySmall: const TextStyle(color: darkTextGray),
        labelLarge: const TextStyle(color: darkTextWhite),
        labelMedium: const TextStyle(color: darkTextGray),
        labelSmall: const TextStyle(color: darkTextGray),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: darkTextWhite,
        iconTheme: IconThemeData(color: darkTextWhite),
      ),

      iconTheme: const IconThemeData(color: darkTextWhite),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkAccentWhite,
          foregroundColor: darkPrimaryBlack,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkAccentWhite,
          side: const BorderSide(color: darkAccentWhite),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: darkTextGray),
        hintStyle: const TextStyle(color: darkTextGray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkAccentWhite, width: 2),
        ),
      ),

      cardTheme: CardThemeData(
        color: darkSurfaceGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: darkBorderGray, width: 1),
        ),
      ),


      dividerTheme: const DividerThemeData(
        color: darkBorderGray,
        thickness: 1,
      ),
    );
  }

  // ============================================================================
  // LIGHT THEME
  // ============================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundWhite,

      colorScheme: const ColorScheme.light(
        primary: lightAccentBlack,
        secondary: lightTextGray,
        surface: lightSurfaceWhite,
        background: lightBackgroundWhite,
        onPrimary: lightPrimaryWhite,
        onSecondary: lightBackgroundWhite,
        onSurface: lightTextBlack,
        onBackground: lightTextBlack,
      ),

      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: const TextStyle(color: lightTextBlack),
        displayMedium: const TextStyle(color: lightTextBlack),
        displaySmall: const TextStyle(color: lightTextBlack),
        headlineLarge: const TextStyle(color: lightTextBlack),
        headlineMedium: const TextStyle(color: lightTextBlack),
        headlineSmall: const TextStyle(color: lightTextBlack),
        titleLarge: const TextStyle(color: lightTextBlack),
        titleMedium: const TextStyle(color: lightTextBlack),
        titleSmall: const TextStyle(color: lightTextBlack),
        bodyLarge: const TextStyle(color: lightTextBlack),
        bodyMedium: const TextStyle(color: lightTextBlack),
        bodySmall: const TextStyle(color: lightTextGray),
        labelLarge: const TextStyle(color: lightTextBlack),
        labelMedium: const TextStyle(color: lightTextGray),
        labelSmall: const TextStyle(color: lightTextGray),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: lightTextBlack,
        iconTheme: IconThemeData(color: lightTextBlack),
      ),

      iconTheme: const IconThemeData(color: lightTextBlack),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightAccentBlack,
          foregroundColor: lightPrimaryWhite,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightAccentBlack,
          side: const BorderSide(color: lightAccentBlack),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: lightTextGray),
        hintStyle: const TextStyle(color: lightTextGray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightAccentBlack, width: 2),
        ),
      ),

      cardTheme: CardThemeData(
        color: lightSurfaceWhite,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: lightBorderGray, width: 1),
        ),
      ),


      dividerTheme: const DividerThemeData(
        color: lightBorderGray,
        thickness: 1,
      ),
    );
  }

  // ============================================================================
  // HELPER METHODS FOR THEME-AWARE COLORS
  // ============================================================================

  /// Returns appropriate background color based on theme
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundBlack
        : lightBackgroundWhite;
  }

  /// Returns appropriate surface color based on theme
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceGray
        : lightSurfaceWhite;
  }

  /// Returns appropriate border color based on theme
  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderGray
        : lightBorderGray;
  }

  /// Returns appropriate primary text color based on theme
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextWhite
        : lightTextBlack;
  }

  /// Returns appropriate secondary text color based on theme
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextGray
        : lightTextGray;
  }

  /// Returns appropriate accent color based on theme
  static Color getAccentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkAccentWhite
        : lightAccentBlack;
  }

  /// Returns appropriate glass card background color based on theme
  static Color getGlassCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceGray
        : lightSurfaceWhite;
  }
}