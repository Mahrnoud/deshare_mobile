// ============================================================================
// FILE: lib/models/driver.dart
// ============================================================================
class Driver {
  final String id;
  final String name;
  final double rating;
  final int deliveriesCount;
  final double distanceKm;

  Driver({
    required this.id,
    required this.name,
    required this.rating,
    required this.deliveriesCount,
    required this.distanceKm,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'rating': rating,
    'deliveriesCount': deliveriesCount,
    'distanceKm': distanceKm,
  };

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json['id'],
    name: json['name'],
    rating: json['rating'],
    deliveriesCount: json['deliveriesCount'],
    distanceKm: json['distanceKm'],
  );
}