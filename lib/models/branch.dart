
// ============================================================================
// FILE: lib/models/branch.dart
// ============================================================================
class Branch {
  final String name;
  final String country;
  final String city;
  final String region;
  final String address;
  final double latitude;
  final double longitude;
  final String landline;
  final String mobile;
  final String? additionalMobile;

  Branch({
    required this.name,
    required this.country,
    required this.city,
    required this.region,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.landline,
    required this.mobile,
    this.additionalMobile,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'city': city,
    'region': region,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'landline': landline,
    'mobile': mobile,
    'additionalMobile': additionalMobile,
  };

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    name: json['name'],
    country: json['country'],
    city: json['city'],
    region: json['region'],
    address: json['address'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    landline: json['landline'],
    mobile: json['mobile'],
    additionalMobile: json['additionalMobile'],
  );
}
