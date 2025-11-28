// ============================================================================
// FILE: lib/providers/request_provider.dart
// ============================================================================
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/delivery_request.dart';
import '../models/offer.dart';
import '../services/persistence_service.dart';
import '../services/mock_backend_service.dart';
import 'settings_provider.dart';

class RequestProvider with ChangeNotifier {
  final PersistenceService _persistence = PersistenceService();
  final SettingsProvider _settings;

  DeliveryRequest? _activeRequest;
  StreamSubscription? _offerSubscription;
  StreamSubscription? _deliverySubscription;
  Timer? _expirationTimer;
  Timer? _offerCleanupTimer;

  RequestProvider(this._settings);

  DeliveryRequest? get activeRequest => _activeRequest;
  bool get hasActiveRequest => _activeRequest != null && _activeRequest!.isActive;

  Future<void> init() async {
    _activeRequest = await _persistence.loadActiveRequest();
    if (_activeRequest != null) {
      _resumeRequest();
    }
    notifyListeners();
  }

  Future<void> createRequest(DeliveryRequest request) async {
    _activeRequest = request;
    _activeRequest!.addTimelineEvent('Request created');

    final backend = MockBackendService(
      fastTimers: _settings.fastTimers,
      forceNoDrivers: _settings.forceNoDrivers,
    );

    _activeRequest!.expiresAt = DateTime.now().add(backend.requestExpiration);
    await _persistence.saveActiveRequest(_activeRequest);
    notifyListeners();

    _startExpirationTimer();
    _startOfferListener(backend);
    _startOfferCleanup();
  }

  void _startOfferListener(MockBackendService backend) {
    _offerSubscription?.cancel();
    _offerSubscription = backend.simulateOfferGeneration(
      _activeRequest!,
          (event) {
        _activeRequest!.addTimelineEvent(event);
        _persistence.saveActiveRequest(_activeRequest);
      },
    ).listen((offer) {
      _activeRequest!.offers = [..._activeRequest!.offers, offer];
      if (_activeRequest!.status == RequestStatus.searching) {
        _activeRequest!.status = RequestStatus.offerReceived;
      }
      _activeRequest!.addTimelineEvent('New offer received from ${offer.driverName}');
      _persistence.saveActiveRequest(_activeRequest);
      notifyListeners();
    });
  }

  void _startOfferCleanup() {
    _offerCleanupTimer?.cancel();
    _offerCleanupTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_activeRequest == null) return;

      final before = _activeRequest!.offers.length;
      _activeRequest!.offers = _activeRequest!.offers
          .where((o) => !o.isExpired)
          .toList();

      if (before != _activeRequest!.offers.length) {
        if (_activeRequest!.offers.isEmpty &&
            _activeRequest!.status == RequestStatus.offerReceived) {
          _activeRequest!.status = RequestStatus.searching;
        }
        _persistence.saveActiveRequest(_activeRequest);
        notifyListeners();
      }
    });
  }

  void _startExpirationTimer() {
    _expirationTimer?.cancel();
    _expirationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_activeRequest == null) return;

      if (_activeRequest!.isExpired &&
          _activeRequest!.status != RequestStatus.accepted &&
          _activeRequest!.status != RequestStatus.delivered) {
        _expireRequest();
      }
      notifyListeners();
    });
  }

  void _expireRequest() {
    _activeRequest!.status = RequestStatus.expired;
    _activeRequest!.addTimelineEvent('Request expired - no driver accepted');
    _offerSubscription?.cancel();
    _offerCleanupTimer?.cancel();
    _expirationTimer?.cancel();
    _persistence.saveActiveRequest(_activeRequest);
    notifyListeners();
  }

  Future<void> acceptOffer(Offer offer) async {
    if (_activeRequest == null) return;

    _activeRequest!.status = RequestStatus.accepted;
    _activeRequest!.acceptedOfferId = offer.id;
    _activeRequest!.acceptedDriverId = offer.driverId;
    _activeRequest!.offers = [offer];
    _activeRequest!.addTimelineEvent('Accepted offer from ${offer.driverName}');

    _offerSubscription?.cancel();
    _offerCleanupTimer?.cancel();
    _expirationTimer?.cancel();

    await _persistence.saveActiveRequest(_activeRequest);
    notifyListeners();

    final backend = MockBackendService(fastTimers: _settings.fastTimers);
    _startDeliverySimulation(backend);
  }

  void _startDeliverySimulation(MockBackendService backend) {
    _deliverySubscription?.cancel();
    _deliverySubscription = backend.simulateDeliveryProgress(
      _activeRequest!,
          (event) {
        _activeRequest!.addTimelineEvent(event);
        _persistence.saveActiveRequest(_activeRequest);
      },
    ).listen((status) {
      _activeRequest!.status = status;
      _persistence.saveActiveRequest(_activeRequest);
      notifyListeners();

      if (status == RequestStatus.delivered) {
        _deliverySubscription?.cancel();
      }
    });
  }

  Future<void> retryRequest() async {
    if (_activeRequest == null) return;

    final newRequest = DeliveryRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      status: RequestStatus.searching,
      stops: _activeRequest!.stops,
      timeline: [],
    );

    await createRequest(newRequest);
  }

  Future<void> cancelRequest() async {
    if (_activeRequest == null) return;

    _activeRequest!.status = RequestStatus.cancelled;
    _activeRequest!.addTimelineEvent('Request cancelled by store');

    _offerSubscription?.cancel();
    _deliverySubscription?.cancel();
    _offerCleanupTimer?.cancel();
    _expirationTimer?.cancel();

    await _persistence.saveActiveRequest(_activeRequest);
    notifyListeners();
  }

  Future<void> clearActiveRequest() async {
    _activeRequest = null;
    _offerSubscription?.cancel();
    _deliverySubscription?.cancel();
    _offerCleanupTimer?.cancel();
    _expirationTimer?.cancel();
    await _persistence.saveActiveRequest(null);
    notifyListeners();
  }

  void _resumeRequest() {
    if (_activeRequest == null) return;

    final backend = MockBackendService(
      fastTimers: _settings.fastTimers,
      forceNoDrivers: _settings.forceNoDrivers,
    );

    if (_activeRequest!.status == RequestStatus.searching ||
        _activeRequest!.status == RequestStatus.offerReceived) {
      if (_activeRequest!.isExpired) {
        _expireRequest();
      } else {
        _startExpirationTimer();
        _startOfferCleanup();
      }
    } else if (_activeRequest!.status == RequestStatus.accepted ||
        _activeRequest!.status == RequestStatus.onWayToStore ||
        _activeRequest!.status == RequestStatus.onWayToCustomer) {
      _startDeliverySimulation(backend);
    }
  }

  @override
  void dispose() {
    _offerSubscription?.cancel();
    _deliverySubscription?.cancel();
    _offerCleanupTimer?.cancel();
    _expirationTimer?.cancel();
    super.dispose();
  }
}