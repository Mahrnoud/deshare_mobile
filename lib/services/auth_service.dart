// ============================================================================
// FILE: lib/services/auth_service.dart
// ============================================================================
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/registration_data.dart';

class AuthService {
  static const String _registrationKey = 'registration_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentUserKey = 'current_user';

  Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_registrationKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> saveRegistration(RegistrationData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registrationKey, jsonEncode(data.toJson()));
  }

  Future<RegistrationData?> getRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_registrationKey);
    if (data == null) return null;

    try {
      return RegistrationData.fromJson(jsonDecode(data));
    } catch (e) {
      return null;
    }
  }

  Future<bool> authenticate(String mobile, String password) async {
    final registration = await getRegistration();
    if (registration == null) return false;

    final isValid = registration.manager.mobile == mobile &&
        registration.manager.password == password;

    if (isValid) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_currentUserKey, jsonEncode({
        'name': registration.manager.name,
        'mobile': registration.manager.mobile,
      }));
    }

    return isValid;
  }

  Future<Map<String, String>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_currentUserKey);
    if (userData == null) return null;

    try {
      final data = jsonDecode(userData);
      return {
        'name': data['name'],
        'mobile': data['mobile'],
      };
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_currentUserKey);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_registrationKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_currentUserKey);
  }
}
