// ============================================================================
// FILE: lib/models/delivery_request.dart
// ============================================================================
import 'delivery_stop.dart';
import 'offer.dart';

enum RequestStatus {
  searching,
  offerReceived,
  accepted,
  onWayToStore,
  pickupComplete,
  onWayToCustomer,
  delivered,
  expired,
  cancelled,
}

class DeliveryRequest {
  final String id;
  final DateTime createdAt;
  RequestStatus status;
  List<DeliveryStop> stops;
  List<Offer> offers;
  String? acceptedOfferId;
  String? acceptedDriverId;
  DateTime? expiresAt;
  List<String> timeline;

  DeliveryRequest({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.stops,
    this.offers = const [],
    this.acceptedOfferId,
    this.acceptedDriverId,
    this.expiresAt,
    this.timeline = const [],
  });

  double get subtotalOrders => stops.fold(0, (sum, stop) => sum + stop.orderAmount);
  double get totalDeliveryFees => stops.fold(0, (sum, stop) => sum + stop.deliveryFee);
  double get grandTotal => subtotalOrders + totalDeliveryFees;

  bool get isActive => status != RequestStatus.delivered &&
      status != RequestStatus.expired &&
      status != RequestStatus.cancelled;

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  Duration? get remainingTime {
    if (expiresAt == null) return null;
    final remaining = expiresAt!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  void addTimelineEvent(String event) {
    timeline = [...timeline, '${DateTime.now().toIso8601String()}|$event'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'status': status.name,
    'stops': stops.map((s) => s.toJson()).toList(),
    'offers': offers.map((o) => o.toJson()).toList(),
    'acceptedOfferId': acceptedOfferId,
    'acceptedDriverId': acceptedDriverId,
    'expiresAt': expiresAt?.toIso8601String(),
    'timeline': timeline,
  };

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) => DeliveryRequest(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    status: RequestStatus.values.firstWhere((e) => e.name == json['status']),
    stops: (json['stops'] as List).map((s) => DeliveryStop.fromJson(s)).toList(),
    offers: (json['offers'] as List).map((o) => Offer.fromJson(o)).toList(),
    acceptedOfferId: json['acceptedOfferId'],
    acceptedDriverId: json['acceptedDriverId'],
    expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    timeline: List<String>.from(json['timeline'] ?? []),
  );
}