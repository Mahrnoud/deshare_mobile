// ============================================================================
// FILE: lib/services/persistence_service.dart
// ============================================================================
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/delivery_request.dart';

class PersistenceService {
  static const String _activeRequestKey = 'active_request';
  static const String _historyKey = 'request_history';
  static const String _onboardingKey = 'onboarding_shown';
  static const String _settingsKey = 'app_settings';

  Future<void> saveActiveRequest(DeliveryRequest? request) async {
    final prefs = await SharedPreferences.getInstance();
    if (request == null) {
      await prefs.remove(_activeRequestKey);
    } else {
      await prefs.setString(_activeRequestKey, jsonEncode(request.toJson()));
    }
  }

  Future<DeliveryRequest?> loadActiveRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_activeRequestKey);
    if (data == null) return null;
    try {
      return DeliveryRequest.fromJson(jsonDecode(data));
    } catch (e) {
      return null;
    }
  }

  Future<void> saveHistory(List<DeliveryRequest> requests) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(requests.map((r) => r.toJson()).toList());
    await prefs.setString(_historyKey, data);
  }

  Future<List<DeliveryRequest>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_historyKey);
    if (data == null) return [];
    try {
      final List<dynamic> list = jsonDecode(data);
      return list.map((r) => DeliveryRequest.fromJson(r)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings));
  }

  Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_settingsKey);
    if (data == null) return {};
    try {
      return Map<String, dynamic>.from(jsonDecode(data));
    } catch (e) {
      return {};
    }
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
