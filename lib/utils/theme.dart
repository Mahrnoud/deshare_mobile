// ============================================================================
// FILE: lib/utils/theme.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0E27),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00D9FF),
        secondary: Color(0xFFFF006E),
        surface: Color(0xFF1A1F3A),
        background: Color(0xFF0A0E27),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}