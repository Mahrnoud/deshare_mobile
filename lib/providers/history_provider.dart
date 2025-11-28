// ============================================================================
// FILE: lib/providers/history_provider.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../models/delivery_request.dart';
import '../services/persistence_service.dart';
import '../services/mock_backend_service.dart';

class HistoryProvider with ChangeNotifier {
  final PersistenceService _persistence = PersistenceService();
  List<DeliveryRequest> _history = [];

  List<DeliveryRequest> get history => _history;

  List<DeliveryRequest> getFilteredHistory(RequestStatus? filter) {
    if (filter == null) return _history;
    return _history.where((r) => r.status == filter).toList();
  }

  Future<void> init() async {
    _history = await _persistence.loadHistory();
    notifyListeners();
  }

  Future<void> addToHistory(DeliveryRequest request) async {
    _history.insert(0, request);
    await _persistence.saveHistory(_history);
    notifyListeners();
  }

  Future<void> seedFakeData() async {
    final service = MockBackendService();
    for (int i = 0; i < 5; i++) {
      _history.add(service.generateFakeRequest(i));
    }
    await _persistence.saveHistory(_history);
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history = [];
    await _persistence.saveHistory(_history);
    notifyListeners();
  }
}
