
// ============================================================================
// FILE: lib/models/manager.dart
// ============================================================================
class Manager {
  final String name;
  final String mobile;
  final String password;

  Manager({
    required this.name,
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'mobile': mobile,
    'password': password,
  };

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    name: json['name'],
    mobile: json['mobile'],
    password: json['password'],
  );
}
