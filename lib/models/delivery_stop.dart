// ============================================================================
// FILE: lib/models/delivery_stop.dart
// ============================================================================
class DeliveryStop {
  final String id;
  String addressText;
  double? latitude;
  double? longitude;
  double orderAmount;
  double deliveryFee;
  String notes;
  String status;

  DeliveryStop({
    required this.id,
    required this.addressText,
    this.latitude,
    this.longitude,
    required this.orderAmount,
    required this.deliveryFee,
    this.notes = '',
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'addressText': addressText,
    'latitude': latitude,
    'longitude': longitude,
    'orderAmount': orderAmount,
    'deliveryFee': deliveryFee,
    'notes': notes,
    'status': status,
  };

  factory DeliveryStop.fromJson(Map<String, dynamic> json) => DeliveryStop(
    id: json['id'],
    addressText: json['addressText'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    orderAmount: json['orderAmount'],
    deliveryFee: json['deliveryFee'],
    notes: json['notes'] ?? '',
    status: json['status'] ?? 'pending',
  );
}