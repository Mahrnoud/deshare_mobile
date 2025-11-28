// ============================================================================
// FILE: lib/services/geocoding_service.dart
// ============================================================================
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressSuggestion {
  final String addressText;
  final double? latitude;
  final double? longitude;
  final String? placeId;

  AddressSuggestion({
    required this.addressText,
    this.latitude,
    this.longitude,
    this.placeId,
  });
}

class GeocodingService {
  // Add your Google Geolocation API key here
  static const String _apiKey = '';
  static final bool _useRealApi = _apiKey.isNotEmpty;

  // Mock data for testing without API key
  static final List<AddressSuggestion> _mockSuggestions = [
    AddressSuggestion(
      addressText: 'شارع مؤسسة الذكاه - المرج، Cairo',
      latitude: 30.1272,
      longitude: 31.3187,
    ),
    AddressSuggestion(
      addressText: 'شارع الهرم، الجيزة، Cairo',
      latitude: 29.9792,
      longitude: 31.1342,
    ),
    AddressSuggestion(
      addressText: '123 Main Street, Downtown Cairo',
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    AddressSuggestion(
      addressText: 'شارع التحرير، وسط البلد، Cairo',
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    AddressSuggestion(
      addressText: 'Nasr City, Cairo Governorate',
      latitude: 30.0561,
      longitude: 31.3656,
    ),
  ];

  Future<List<AddressSuggestion>> getSuggestions(String query) async {
    if (query.trim().isEmpty) return [];

    if (!_useRealApi) {
      // Mock suggestions
      await Future.delayed(const Duration(milliseconds: 300));
      return _mockSuggestions
          .where((s) => s.addressText.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    try {
      // Real Google API call
      final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=${Uri.encodeComponent(query)}'
          '&key=$_apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final predictions = data['predictions'] as List;

        return predictions.map((p) => AddressSuggestion(
          addressText: p['description'],
          placeId: p['place_id'],
        )).toList();
      }
    } catch (e) {
      // Fallback to mock on error
    }

    return _mockSuggestions
        .where((s) => s.addressText.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}