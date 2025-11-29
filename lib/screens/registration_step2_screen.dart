// ============================================================================
// FILE: lib/screens/registration_step2_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import '../services/location_service.dart';
import '../services/location_data_service.dart';
import '../widgets/glass_card.dart';
import 'registration_step3_screen.dart';
import 'login_screen.dart';

class RegistrationStep2Screen extends StatefulWidget {
  const RegistrationStep2Screen({super.key});

  @override
  State<RegistrationStep2Screen> createState() =>
      _RegistrationStep2ScreenState();
}

class _RegistrationStep2ScreenState extends State<RegistrationStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _branchNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _landlineController = TextEditingController();
  final _mobileController = TextEditingController();
  final _additionalMobileController = TextEditingController();
  final _locationService = LocationService();
  final _locationDataService = LocationDataService();

  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedRegion;
  List<String> _availableCities = [];
  List<String> _availableRegions = [];

  double? _latitude;
  double? _longitude;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _branchNameController.text = provider.branchName ?? '';
    _addressController.text = provider.address ?? '';
    _landlineController.text = provider.landline ?? '';
    _mobileController.text = provider.mobile ?? '';
    _additionalMobileController.text = provider.additionalMobile ?? '';

    _selectedCountry = provider.country;
    _selectedCity = provider.city;
    _selectedRegion = provider.region;
    _latitude = provider.latitude;
    _longitude = provider.longitude;

    // Initialize cascading dropdowns
    if (_selectedCountry != null) {
      _availableCities = _locationDataService.getCitiesByCountry(_selectedCountry!);
      if (_selectedCity != null) {
        _availableRegions = _locationDataService.getRegionsByCity(_selectedCity!);
      }
    }
  }

  @override
  void dispose() {
    _branchNameController.dispose();
    _addressController.dispose();
    _landlineController.dispose();
    _mobileController.dispose();
    _additionalMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressIndicator(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 32),
                      _buildForm(),
                      const SizedBox(height: 32),
                      _buildButtons(),
                      const SizedBox(height: 16),
                      _buildLoginLink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_city,
              color: Color(0xFF00D9FF),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Branch Registration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Step 2 of 3',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildProgressDot(true),
          _buildProgressLine(true),
          _buildProgressDot(true),
          _buildProgressLine(false),
          _buildProgressDot(false),
        ],
      ),
    );
  }

  Widget _buildProgressDot(bool active) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF00D9FF) : Colors.white30,
      ),
    );
  }

  Widget _buildProgressLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? const Color(0xFF00D9FF) : Colors.white30,
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Branch',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Add your first branch location and contact details',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: _branchNameController,
              label: 'Branch Name *',
              icon: Icons.business,
              validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter branch name' : null,
            ),
            const SizedBox(height: 16),

            // Country Dropdown
            _buildDropdownField(
              label: 'Country *',
              icon: Icons.public,
              value: _selectedCountry,
              items: _locationDataService.getCountries(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _selectedCity = null;
                  _selectedRegion = null;
                  _availableCities = value != null
                      ? _locationDataService.getCitiesByCountry(value)
                      : [];
                  _availableRegions = [];
                });
              },
              validator: (value) =>
              value == null ? 'Please select a country' : null,
            ),
            const SizedBox(height: 16),

            // City Dropdown (depends on Country)
            _buildDropdownField(
              label: 'City *',
              icon: Icons.location_city,
              value: _selectedCity,
              items: _availableCities,
              onChanged: _selectedCountry == null
                  ? null
                  : (value) {
                setState(() {
                  _selectedCity = value;
                  _selectedRegion = null;
                  _availableRegions = value != null
                      ? _locationDataService.getRegionsByCity(value)
                      : [];
                });
              },
              validator: (value) =>
              value == null ? 'Please select a city' : null,
            ),
            const SizedBox(height: 16),

            // Region Dropdown (depends on City)
            _buildDropdownField(
              label: 'Region *',
              icon: Icons.map,
              value: _selectedRegion,
              items: _availableRegions,
              onChanged: _selectedCity == null
                  ? null
                  : (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
              validator: (value) =>
              value == null ? 'Please select a region' : null,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _addressController,
              label: 'Address *',
              icon: Icons.home,
              maxLines: 2,
              validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter address' : null,
            ),
            const SizedBox(height: 16),
            _buildLocationButton(),
            if (_latitude != null && _longitude != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Location: ${_locationService.formatCoordinates(_latitude!, _longitude!)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00FF88),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _landlineController,
              label: 'Landline *',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter landline';
                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                  return 'Must contain only digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _mobileController,
              label: 'Mobile *',
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter mobile';
                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                  return 'Must contain only digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _additionalMobileController,
              label: 'Additional Mobile (Optional)',
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Must contain only digits';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFF00D9FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00D9FF), width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF1A1F3A),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFF00D9FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00D9FF), width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white10),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildLocationButton() {
    return ElevatedButton.icon(
      onPressed: _isLoadingLocation ? null : _getCurrentLocation,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF006E).withOpacity(0.2),
        foregroundColor: const Color(0xFFFF006E),
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: Color(0xFFFF006E)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: _isLoadingLocation
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF006E)),
        ),
      )
          : const Icon(Icons.my_location),
      label: Text(
        _isLoadingLocation ? 'Getting Location...' : 'Get Current Location',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.white30, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _handleNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D9FF),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF00D9FF).withOpacity(0.5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: Colors.white60,
          ),
          children: [
            TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Color(0xFF00D9FF),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      final location = await _locationService.getCurrentLocation();
      setState(() {
        _latitude = location['latitude'];
        _longitude = location['longitude'];
      });

      final provider =
      Provider.of<RegistrationProvider>(context, listen: false);
      provider.setLocation(_latitude!, _longitude!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to get location. Using mock coordinates.'),
          ),
        );
      }
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      if (_latitude == null || _longitude == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please get current location first'),
            backgroundColor: Color(0xFFFF006E),
          ),
        );
        return;
      }

      final provider =
      Provider.of<RegistrationProvider>(context, listen: false);
      provider.setBranchInfo(
        name: _branchNameController.text,
        country: _selectedCountry!,
        city: _selectedCity!,
        region: _selectedRegion!,
        address: _addressController.text,
        latitude: _latitude!,
        longitude: _longitude!,
        landline: _landlineController.text,
        mobile: _mobileController.text,
        additionalMobile: _additionalMobileController.text.isEmpty
            ? null
            : _additionalMobileController.text,
      );
      provider.nextStep();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationStep3Screen()),
      );
    }
  }
}