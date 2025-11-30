// ============================================================================
// FILE: lib/screens/registration_step1_screen.dart
// ============================================================================
import 'package:deshare/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import 'registration_step2_screen.dart';

class RegistrationStep1Screen extends StatefulWidget {
  const RegistrationStep1Screen({super.key});

  @override
  State<RegistrationStep1Screen> createState() =>
      _RegistrationStep1ScreenState();
}

class _RegistrationStep1ScreenState extends State<RegistrationStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _hotlineController = TextEditingController();
  String? _selectedStoreType;

  final List<String> _storeTypes = [
    'Restaurant',
    'Pharmacy',
    'Supermarket',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _storeNameController.text = provider.storeName ?? '';
    _hotlineController.text = provider.storeHotline ?? '';
    _selectedStoreType = provider.storeType;
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _hotlineController.dispose();
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 32),
                      _buildForm(),
                      const SizedBox(height: 32),
                      _buildNextButton(),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.store,
              color: AppTheme.getTextColor(context),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Store Registration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                'Step 1 of 3',
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildProgressDot(true),
          _buildProgressLine(false),
          _buildProgressDot(false),
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
          'Store Information',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Let\'s start by setting up your store',
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
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedStoreType,
              dropdownColor: AppTheme.getBackgroundColor(context),
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: 'Store Type *',
                labelStyle: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon: Icon(Icons.category, color: AppTheme.getTextColor(context)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              items: _storeTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedStoreType = value);
              },
              validator: (value) =>
              value == null ? 'Please select a store type' : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _storeNameController,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: 'Store Name *',
                labelStyle: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon: Icon(Icons.storefront, color: AppTheme.getTextColor(context)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? 'Please enter store name' : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _hotlineController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: 'Hotline *',
                labelStyle: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon: Icon(Icons.phone, color: AppTheme.getTextColor(context)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter hotline number';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Hotline must contain only digits';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: _handleNext,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.getTextColor(context),
        foregroundColor: AppTheme.getBackgroundColor(context),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Next',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.getSecondaryTextColor(context),
          ),
          children: [
            TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: AppTheme.getTextColor(context),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      final provider =
      Provider.of<RegistrationProvider>(context, listen: false);

      provider.setStoreInfo(
        _selectedStoreType!,
        _storeNameController.text,
        _hotlineController.text,
      );

      provider.nextStep();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationStep2Screen()),
      );
    }
  }
}
