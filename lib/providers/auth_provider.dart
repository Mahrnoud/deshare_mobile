// ============================================================================
// FILE: lib/providers/auth_provider.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/registration_data.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoggedIn = false;
  bool _isRegistered = false;
  Map<String, String>? _currentUser;
  RegistrationData? _registrationData;

  bool get isLoggedIn => _isLoggedIn;
  bool get isRegistered => _isRegistered;
  Map<String, String>? get currentUser => _currentUser;
  RegistrationData? get registrationData => _registrationData;

  Future<void> init() async {
    _isRegistered = await _authService.isRegistered();
    _isLoggedIn = await _authService.isLoggedIn();

    if (_isLoggedIn) {
      _currentUser = await _authService.getCurrentUser();
    }

    if (_isRegistered) {
      _registrationData = await _authService.getRegistration();
    }

    notifyListeners();
  }

  Future<bool> login(String mobile, String password) async {
    final success = await _authService.authenticate(mobile, password);

    if (success) {
      _isLoggedIn = true;
      _currentUser = await _authService.getCurrentUser();
      notifyListeners();
    }

    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> completeRegistration(RegistrationData data) async {
    await _authService.saveRegistration(data);
    _isRegistered = true;
    _registrationData = data;
    notifyListeners();
  }
}

