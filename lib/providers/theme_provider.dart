// ============================================================================
// FILE: lib/providers/theme_provider.dart (NEW)
// ============================================================================
import 'package:flutter/material.dart';
import '../services/persistence_service.dart';

class ThemeProvider with ChangeNotifier {
  final PersistenceService _persistence = PersistenceService();

  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> init() async {
    final settings = await _persistence.loadSettings();
    final isDark = settings['isDarkMode'] ?? true; // Default to dark
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _saveTheme();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveTheme();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final settings = await _persistence.loadSettings();
    settings['isDarkMode'] = _themeMode == ThemeMode.dark;
    await _persistence.saveSettings(settings);
  }
}