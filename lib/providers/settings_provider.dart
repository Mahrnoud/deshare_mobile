// ============================================================================
// FILE: lib/providers/settings_provider.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../services/persistence_service.dart';

class SettingsProvider with ChangeNotifier {
  final PersistenceService _persistence = PersistenceService();

  bool _fastTimers = false;
  bool _forceNoDrivers = false;
  bool _debugMode = false;

  bool get fastTimers => _fastTimers;
  bool get forceNoDrivers => _forceNoDrivers;
  bool get debugMode => _debugMode;

  Future<void> init() async {
    final settings = await _persistence.loadSettings();
    _fastTimers = settings['fastTimers'] ?? false;
    _forceNoDrivers = settings['forceNoDrivers'] ?? false;
    _debugMode = settings['debugMode'] ?? false;
    notifyListeners();
  }

  Future<void> setFastTimers(bool value) async {
    _fastTimers = value;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> setForceNoDrivers(bool value) async {
    _forceNoDrivers = value;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> setDebugMode(bool value) async {
    _debugMode = value;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    await _persistence.saveSettings({
      'fastTimers': _fastTimers,
      'forceNoDrivers': _forceNoDrivers,
      'debugMode': _debugMode,
    });
  }

  Future<void> clearAllData() async {
    await _persistence.clearAll();
    _fastTimers = false;
    _forceNoDrivers = false;
    _debugMode = false;
    notifyListeners();
  }
}