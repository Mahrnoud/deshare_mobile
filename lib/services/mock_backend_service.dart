// ============================================================================
// FILE: lib/services/mock_backend_service.dart
// ============================================================================
import 'dart:async';
import 'dart:math';

import '../models/delivery_request.dart';
import '../models/delivery_stop.dart';
import '../models/driver.dart';
import '../models/offer.dart';
import '../utils/constants.dart';

class MockBackendService {
  final Random _random = Random();
  final bool fastTimers;
  final bool forceNoDrivers;

  MockBackendService({
    this.fastTimers = false,
    this.forceNoDrivers = false,
  });

  Duration get offerDuration => fastTimers
      ? AppConstants.fastOfferDuration
      : AppConstants.offerDuration;

  Duration get requestExpiration => fastTimers
      ? AppConstants.fastRequestExpiration
      : AppConstants.requestExpiration;

  List<Driver> generateNearbyDrivers(int count) {
    if (forceNoDrivers) return [];

    final names = ['Ahmed', 'Mohamed', 'Hassan', 'Youssef', 'Omar', 'Ali'];
    final drivers = <Driver>[];

    for (int i = 0; i < count; i++) {
      drivers.add(Driver(
        id: 'driver_${DateTime.now().millisecondsSinceEpoch}_$i',
        name: names[_random.nextInt(names.length)],
        rating: 4.0 + _random.nextDouble(),
        deliveriesCount: 50 + _random.nextInt(450),
        distanceKm: 0.5 + _random.nextDouble() * 4.5,
      ));
    }

    return drivers;
  }

  Stream<Offer> simulateOfferGeneration(
      DeliveryRequest request,
      Function(String) onTimelineEvent,
      ) async* {
    final driverCount = forceNoDrivers ? 0 : _random.nextInt(3) + 1;
    final drivers = generateNearbyDrivers(driverCount);

    if (drivers.isEmpty) {
      onTimelineEvent('No drivers available in area');
      return;
    }

    onTimelineEvent('Found ${drivers.length} nearby driver(s)');

    for (final driver in drivers) {
      final delay = _random.nextInt(
          AppConstants.maxDriverResponseTime - AppConstants.minDriverResponseTime
      ) + AppConstants.minDriverResponseTime;

      await Future.delayed(Duration(seconds: delay));

      final totalFee = request.totalDeliveryFees;
      final useCounterOffer = _random.nextBool();
      final proposedFee = useCounterOffer
          ? totalFee * (1.1 + _random.nextDouble() * 0.3)
          : totalFee;

      final now = DateTime.now();
      final offer = Offer(
        id: 'offer_${now.millisecondsSinceEpoch}_${driver.id}',
        driverId: driver.id,
        driverName: driver.name,
        driverRating: driver.rating,
        proposedFee: proposedFee,
        originalDeliveryFee: totalFee,
        etaMinutes: 5 + _random.nextInt(20),
        createdAt: now,
        expiresAt: now.add(offerDuration),
        isCounterOffer: useCounterOffer,
      );

      onTimelineEvent(
          useCounterOffer
              ? 'Counter-offer from ${driver.name}: \$${proposedFee.toStringAsFixed(2)}'
              : 'Offer received from ${driver.name}'
      );

      yield offer;
    }
  }

  Stream<RequestStatus> simulateDeliveryProgress(
      DeliveryRequest request,
      Function(String) onTimelineEvent,
      ) async* {
    await Future.delayed(const Duration(seconds: 3));
    onTimelineEvent('Driver is on the way to store');
    yield RequestStatus.onWayToStore;

    await Future.delayed(const Duration(seconds: 5));
    onTimelineEvent('Driver arrived at store - picking up orders');
    yield RequestStatus.pickupComplete;

    for (int i = 0; i < request.stops.length; i++) {
      await Future.delayed(const Duration(seconds: 4));
      onTimelineEvent('On the way to customer ${i + 1}');
      yield RequestStatus.onWayToCustomer;

      await Future.delayed(const Duration(seconds: 3));
      onTimelineEvent('Delivered to customer ${i + 1}');
    }

    await Future.delayed(const Duration(seconds: 1));
    onTimelineEvent('All deliveries completed');
    yield RequestStatus.delivered;
  }

  DeliveryRequest generateFakeRequest(int index) {
    final now = DateTime.now().subtract(Duration(hours: index * 2));
    final statuses = [
      RequestStatus.delivered,
      RequestStatus.expired,
      RequestStatus.cancelled,
    ];

    final stops = List.generate(
      1 + _random.nextInt(3),
          (i) => DeliveryStop(
        id: 'stop_$i',
        addressText: _mockAddresses[_random.nextInt(_mockAddresses.length)],
        orderAmount: 20 + _random.nextDouble() * 80,
        deliveryFee: 5 + _random.nextDouble() * 10,
        status: 'delivered',
      ),
    );

    return DeliveryRequest(
      id: 'req_${now.millisecondsSinceEpoch}',
      createdAt: now,
      status: statuses[_random.nextInt(statuses.length)],
      stops: stops,
      timeline: ['${now.toIso8601String()}|Request created'],
    );
  }

  static final List<String> _mockAddresses = [
    'شارع مؤسسة الذكاه - المرج، Cairo',
    'شارع الهرم، الجيزة',
    '123 Main Street, Downtown Cairo',
    'Nasr City, Cairo Governorate',
    'Maadi, Cairo',
  ];
}