
// ============================================================================
// FILE: lib/services/location_service.dart
// ============================================================================
import 'dart:math';

class LocationService {
  // Simulate getting current location
  // In production, use geolocator package
  Future<Map<String, double>> getCurrentLocation() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock coordinates for Cairo, Egypt
    final random = Random();
    final latitude = 30.0444 + (random.nextDouble() - 0.5) * 0.1;
    final longitude = 31.2357 + (random.nextDouble() - 0.5) * 0.1;

    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String formatCoordinates(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
  }
}