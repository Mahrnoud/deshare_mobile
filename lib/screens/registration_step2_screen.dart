// ============================================================================
// FILE: lib/screens/registration_step2_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/registration_provider.dart';
import '../services/location_service.dart';
import '../services/location_data_service.dart';
import '../utils/theme.dart';
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
        decoration: BoxDecoration(
          color: AppTheme.getBackgroundColor(context),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressIndicator(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTitle(),
                      SizedBox(height: 32),
                      _buildForm(),
                      SizedBox(height: 32),
                      _buildButtons(),
                      SizedBox(height: 16),
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
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppTheme.getTextColor(context)),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.location_city,
              color: AppTheme.getTextColor(context),
              size: 32,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.branchRegistration,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.step2Of3,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.getSecondaryTextColor(context),
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
      padding: EdgeInsets.symmetric(horizontal: 24),
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
        color: active ? AppTheme.getTextColor(context) : AppTheme.getBorderColor(context),
      ),
    );
  }

  Widget _buildProgressLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? AppTheme.getTextColor(context) : AppTheme.getBorderColor(context),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.firstBranch,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.addBranchDetails,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.getSecondaryTextColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return GlassCard(
        padding: EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: _branchNameController,
                  label: AppLocalizations.of(context)!.branchName,
                  icon: Icons.business,
                  validator: (value) => value?.isEmpty ?? true
                      ? AppLocalizations.of(context)!.enterBranchName
                      : null,
                ),
                SizedBox(height: 16),
            _buildDropdownField(
              label: AppLocalizations.of(context)!.country,
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
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.selectCountry
                  : null,
            ),
            SizedBox(height: 16),
            _buildDropdownField(
              label: AppLocalizations.of(context)!.city,
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
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.selectCity
                  : null,
            ),
            SizedBox(height: 16),
            _buildDropdownField(
              label: AppLocalizations.of(context)!.region,
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
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.selectRegion
                  : null,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _addressController,
              label: AppLocalizations.of(context)!.address,
              icon: Icons.home,
              maxLines: 2,
              validator: (value) => value?.isEmpty ?? true
                  ? AppLocalizations.of(context)!.enterAddress
                  : null,
            ),
            SizedBox(height: 16),
            _buildLocationButton(),
            if (_latitude != null && _longitude != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context)!.location(
                      _locationService.formatCoordinates(_latitude!, _longitude!)),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _landlineController,
              label: AppLocalizations.of(context)!.landline,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return AppLocalizations.of(context)!.enterLandline;
                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                  return AppLocalizations.of(context)!.mustContainDigits;
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _mobileController,
              label: AppLocalizations.of(context)!.mobile,
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return AppLocalizations.of(context)!.enterMobile;
                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                  return AppLocalizations.of(context)!.mustContainDigits;
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _additionalMobileController,
              label: AppLocalizations.of(context)!.additionalMobile,
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.mustContainDigits;
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
      style: TextStyle(color: AppTheme.getTextColor(context)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
        prefixIcon: Icon(icon, color: AppTheme.getTextColor(context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.accentRed, width: 2),
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
      dropdownColor: AppTheme.getBackgroundColor(context),
      style: TextStyle(color: AppTheme.getTextColor(context)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
        prefixIcon: Icon(icon, color: AppTheme.getTextColor(context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.accentRed, width: 2),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildLocationButton() {
    return ElevatedButton.icon(
      onPressed: _isLoadingLocation ? null : _getCurrentLocation,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.getTextColor(context),
        foregroundColor: AppTheme.getBackgroundColor(context),
        padding: EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: AppTheme.getBorderColor(context)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: _isLoadingLocation
          ? SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentRed),
        ),
      )
          : Icon(Icons.my_location),
      label: Text(
        _isLoadingLocation
            ? AppLocalizations.of(context)!.gettingLocation
            : AppLocalizations.of(context)!.getCurrentLocation,
        style: TextStyle(fontWeight: FontWeight.w600),
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
              padding: EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppTheme.getBorderColor(context), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.back,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextColor(context),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _handleNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.getTextColor(context),
              foregroundColor: AppTheme.getBackgroundColor(context),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.next,
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
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.getSecondaryTextColor(context),
          ),
          children: [
            TextSpan(text: AppLocalizations.of(context)!.alreadyHaveAccount),
            TextSpan(
              text: AppLocalizations.of(context)!.loginAction,
              style: TextStyle(
                color: AppTheme.getAccentColor(context),
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

      final provider = Provider.of<RegistrationProvider>(context, listen: false);
      provider.setLocation(_latitude!, _longitude!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToGetLocation),
            backgroundColor: AppTheme.accentRed,
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
          SnackBar(
            content: Text(AppLocalizations.of(context)!.pleaseGetLocation),
            backgroundColor: AppTheme.accentRed,
          ),
        );
        return;
      }

      final provider = Provider.of<RegistrationProvider>(context, listen: false);
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
