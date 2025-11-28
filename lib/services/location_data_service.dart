// ============================================================================
// FILE: lib/services/location_data_service.dart
// ============================================================================
class LocationDataService {
  // Country data
  static final Map<String, List<String>> _countryToCities = {
    'Egypt': ['Cairo', 'Alexandria', 'Giza', 'Sharm El Sheikh', 'Hurghada'],
    'Saudi Arabia': ['Riyadh', 'Jeddah', 'Mecca', 'Medina', 'Dammam'],
    'United Arab Emirates': ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman', 'Ras Al Khaimah'],
    'Jordan': ['Amman', 'Zarqa', 'Irbid', 'Aqaba', 'Madaba'],
    'Lebanon': ['Beirut', 'Tripoli', 'Sidon', 'Tyre', 'Byblos'],
  };

  // City to regions mapping
  static final Map<String, List<String>> _cityToRegions = {
    // Egypt - Cairo
    'Cairo': ['Nasr City', 'Heliopolis', 'Maadi', 'Zamalek', 'Downtown', 'New Cairo', '6th of October'],
    'Alexandria': ['Miami', 'Stanley', 'Smouha', 'San Stefano', 'Sidi Gaber', 'Agami'],
    'Giza': ['Dokki', 'Mohandessin', 'Haram', 'Faisal', 'Sheikh Zayed', '6th of October'],
    'Sharm El Sheikh': ['Naama Bay', 'Old Market', 'Hadaba', 'Sharks Bay', 'Nabq Bay'],
    'Hurghada': ['Sekalla', 'Dahar', 'El Gouna', 'Sahl Hasheesh', 'Makadi Bay'],

    // Saudi Arabia - Riyadh
    'Riyadh': ['Al Olaya', 'Al Malaz', 'King Fahd', 'Diplomatic Quarter', 'Al Nakheel', 'Al Sulimaniyah'],
    'Jeddah': ['Al Balad', 'Al Hamra', 'Al Rawdah', 'Al Khalidiyah', 'Obhur', 'North Jeddah'],
    'Mecca': ['Al Haram', 'Al Aziziyah', 'Al Shawqiyah', 'Al Mansour', 'Al Kakiyah'],
    'Medina': ['Al Haram', 'Quba', 'Al Aqiq', 'Al Aziziyah', 'King Fahd'],
    'Dammam': ['Al Faisaliyah', 'Al Shati', 'Al Mazruiyah', 'Al Adamah', 'Al Jalawiyah'],

    // UAE - Dubai
    'Dubai': ['Downtown', 'Marina', 'JBR', 'Business Bay', 'Jumeirah', 'Deira', 'Bur Dubai'],
    'Abu Dhabi': ['Al Khalidiyah', 'Al Zahiyah', 'Corniche', 'Al Reef', 'Yas Island', 'Saadiyat'],
    'Sharjah': ['Al Qasimia', 'Al Majaz', 'Al Nahda', 'Al Khan', 'Al Taawun'],
    'Ajman': ['Al Nuaimiya', 'Al Rashidiya', 'Al Jurf', 'Al Rawda', 'Corniche'],
    'Ras Al Khaimah': ['Al Nakheel', 'Al Qusaidat', 'Dafan Al Nakheel', 'Al Hamra', 'Al Mairid'],

    // Jordan - Amman
    'Amman': ['Abdali', 'Jabal Amman', 'Swefieh', 'Khalda', 'Shmeisani', 'Dabouq', 'Tla Al Ali'],
    'Zarqa': ['New Zarqa', 'Zarqa Camp', 'Hay Al Janobi', 'Russeifa', 'Hashemite'],
    'Irbid': ['Downtown', 'University Street', 'Al Hay Al Sharqi', 'Al Hashemi', 'Ramtha'],
    'Aqaba': ['Downtown', 'South Beach', 'Tala Bay', 'Ayla', 'Al Saadah'],
    'Madaba': ['Downtown', 'Hay Al Janobi', 'Al Faisaliah', 'Mount Nebo'],

    // Lebanon - Beirut
    'Beirut': ['Achrafieh', 'Hamra', 'Verdun', 'Downtown', 'Mar Mikhael', 'Raouche'],
    'Tripoli': ['El Mina', 'Abu Samra', 'Zeitoun', 'Tal', 'Qobbe'],
    'Sidon': ['Old City', 'Ain El Hilweh', 'Miyeh Miyeh', 'Al Saida', 'Nabatieh'],
    'Tyre': ['Old City', 'Rashidieh', 'El Bass', 'Al Buss', 'Burj El Shimali'],
    'Byblos': ['Old Port', 'Modern City', 'Amchit', 'Fidar', 'Nahr Ibrahim'],
  };

  List<String> getCountries() {
    return _countryToCities.keys.toList()..sort();
  }

  List<String> getCitiesByCountry(String country) {
    return _countryToCities[country] ?? [];
  }

  List<String> getRegionsByCity(String city) {
    return _cityToRegions[city] ?? [];
  }

  bool isValidCountry(String country) {
    return _countryToCities.containsKey(country);
  }

  bool isValidCity(String city, String country) {
    final cities = getCitiesByCountry(country);
    return cities.contains(city);
  }

  bool isValidRegion(String region, String city) {
    final regions = getRegionsByCity(city);
    return regions.contains(region);
  }
}