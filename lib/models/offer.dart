// ============================================================================
// FILE: lib/models/offer.dart
// ============================================================================
class Offer {
  final String id;
  final String driverId;
  final String driverName;
  final double driverRating;
  final double proposedFee;
  final double originalDeliveryFee;
  final int etaMinutes;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isCounterOffer;

  Offer({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.driverRating,
    required this.proposedFee,
    required this.originalDeliveryFee,
    required this.etaMinutes,
    required this.createdAt,
    required this.expiresAt,
    this.isCounterOffer = false,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Duration get remainingTime {
    final remaining = expiresAt.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'driverId': driverId,
    'driverName': driverName,
    'driverRating': driverRating,
    'proposedFee': proposedFee,
    'originalDeliveryFee': originalDeliveryFee,
    'etaMinutes': etaMinutes,
    'createdAt': createdAt.toIso8601String(),
    'expiresAt': expiresAt.toIso8601String(),
    'isCounterOffer': isCounterOffer,
  };

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json['id'],
    driverId: json['driverId'],
    driverName: json['driverName'],
    driverRating: json['driverRating'],
    proposedFee: json['proposedFee'],
    originalDeliveryFee: json['originalDeliveryFee'],
    etaMinutes: json['etaMinutes'],
    createdAt: DateTime.parse(json['createdAt']),
    expiresAt: DateTime.parse(json['expiresAt']),
    isCounterOffer: json['isCounterOffer'] ?? false,
  );
}