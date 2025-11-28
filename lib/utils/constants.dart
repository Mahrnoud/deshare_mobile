// ============================================================================
// FILE: lib/utils/constants.dart
// ============================================================================
class AppConstants {
  static const String appName = 'DeShare';
  static const Duration offerDuration = Duration(seconds: 30);
  static const Duration requestExpiration = Duration(minutes: 10);
  static const Duration fastOfferDuration = Duration(seconds: 5);
  static const Duration fastRequestExpiration = Duration(minutes: 1);

  static const double defaultDeliveryFee = 5.0;
  static const String defaultCurrency = '\$';

  static const int maxDriversToSimulate = 3;
  static const int minDriverResponseTime = 2;
  static const int maxDriverResponseTime = 15;
}