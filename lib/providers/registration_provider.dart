// ============================================================================
// FILE: lib/providers/registration_provider.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../models/store.dart';
import '../models/branch.dart';
import '../models/manager.dart';

class RegistrationProvider with ChangeNotifier {
  int _currentStep = 0;

  // Step 1 data
  String? _storeType;
  String? _storeName;
  String? _storeHotline;

  // Step 2 data
  String? _branchName;
  String? _country;
  String? _city;
  String? _region;
  String? _address;
  double? _latitude;
  double? _longitude;
  String? _landline;
  String? _mobile;
  String? _additionalMobile;

  // Step 3 data
  String? _managerName;
  String? _managerMobile;
  String? _managerPassword;

  int get currentStep => _currentStep;

  // Step 1 getters
  String? get storeType => _storeType;
  String? get storeName => _storeName;
  String? get storeHotline => _storeHotline;

  // Step 2 getters
  String? get branchName => _branchName;
  String? get country => _country;
  String? get city => _city;
  String? get region => _region;
  String? get address => _address;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get landline => _landline;
  String? get mobile => _mobile;
  String? get additionalMobile => _additionalMobile;

  // Step 3 getters
  String? get managerName => _managerName;
  String? get managerMobile => _managerMobile;
  String? get managerPassword => _managerPassword;

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // Step 1 setters
  void setStoreInfo(String type, String name, String hotline) {
    _storeType = type;
    _storeName = name;
    _storeHotline = hotline;
    notifyListeners();
  }

  // Step 2 setters
  void setBranchInfo({
    required String name,
    required String country,
    required String city,
    required String region,
    required String address,
    required double latitude,
    required double longitude,
    required String landline,
    required String mobile,
    String? additionalMobile,
  }) {
    _branchName = name;
    _country = country;
    _city = city;
    _region = region;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
    _landline = landline;
    _mobile = mobile;
    _additionalMobile = additionalMobile;
    notifyListeners();
  }

  void setLocation(double lat, double lng) {
    _latitude = lat;
    _longitude = lng;
    notifyListeners();
  }

  // Step 3 setters
  void setManagerInfo(String name, String mobile, String password) {
    _managerName = name;
    _managerMobile = mobile;
    _managerPassword = password;
    notifyListeners();
  }

  Store? buildStore() {
    if (_storeType == null || _storeName == null || _storeHotline == null) {
      return null;
    }

    return Store(
      type: _storeType!,
      name: _storeName!,
      hotline: _storeHotline!,
    );
  }

  Branch? buildBranch() {
    if (_branchName == null || _country == null || _city == null ||
        _region == null || _address == null || _latitude == null ||
        _longitude == null || _landline == null || _mobile == null) {
      return null;
    }

    return Branch(
      name: _branchName!,
      country: _country!,
      city: _city!,
      region: _region!,
      address: _address!,
      latitude: _latitude!,
      longitude: _longitude!,
      landline: _landline!,
      mobile: _mobile!,
      additionalMobile: _additionalMobile,
    );
  }

  Manager? buildManager() {
    if (_managerName == null || _managerMobile == null || _managerPassword == null) {
      return null;
    }

    return Manager(
      name: _managerName!,
      mobile: _managerMobile!,
      password: _managerPassword!,
    );
  }

  void reset() {
    _currentStep = 0;
    _storeType = null;
    _storeName = null;
    _storeHotline = null;
    _branchName = null;
    _country = null;
    _city = null;
    _region = null;
    _address = null;
    _latitude = null;
    _longitude = null;
    _landline = null;
    _mobile = null;
    _additionalMobile = null;
    _managerName = null;
    _managerMobile = null;
    _managerPassword = null;
    notifyListeners();
  }
}