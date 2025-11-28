
// ============================================================================
// FILE: lib/models/registration_data.dart
// ============================================================================
import 'package:deshare/models/store.dart';

import 'branch.dart';
import 'manager.dart';

class RegistrationData {
  final Store store;
  final Branch branch;
  final Manager manager;
  final DateTime registeredAt;

  RegistrationData({
    required this.store,
    required this.branch,
    required this.manager,
    required this.registeredAt,
  });

  Map<String, dynamic> toJson() => {
    'store': store.toJson(),
    'branch': branch.toJson(),
    'manager': manager.toJson(),
    'registeredAt': registeredAt.toIso8601String(),
  };

  factory RegistrationData.fromJson(Map<String, dynamic> json) => RegistrationData(
    store: Store.fromJson(json['store']),
    branch: Branch.fromJson(json['branch']),
    manager: Manager.fromJson(json['manager']),
    registeredAt: DateTime.parse(json['registeredAt']),
  );
}