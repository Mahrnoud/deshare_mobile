// ============================================================================
// FILE: lib/screens/registration_step3_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/registration_provider.dart';
import '../providers/auth_provider.dart';
import '../models/registration_data.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import 'login_screen.dart';

class RegistrationStep3Screen extends StatefulWidget {
  const RegistrationStep3Screen({super.key});

  @override
  State<RegistrationStep3Screen> createState() =>
      _RegistrationStep3ScreenState();
}

class _RegistrationStep3ScreenState extends State<RegistrationStep3Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _nameController.text = provider.managerName ?? '';
    _mobileController.text = provider.managerMobile ?? '';
    _passwordController.text = provider.managerPassword ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            icon: Icon(Icons.arrow_back,
                color: AppTheme.getTextColor(context)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.person,
              color: AppTheme.getTextColor(context),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.managerAccount,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.step3Of3,
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
          _buildProgressLine(true),
          _buildProgressDot(true),
          _buildProgressLine(true),
          _buildProgressDot(true),
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
          AppLocalizations.of(context)!.managerAccount,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.createManagerAccount,
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
            // NAME
            TextFormField(
              controller: _nameController,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.managerName,
                labelStyle:
                    TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon:
                    Icon(Icons.person, color: AppTheme.getTextColor(context)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? AppLocalizations.of(context)!.enterManagerName
                  : null,
            ),

            const SizedBox(height: 16),

            // MOBILE
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.managerMobile,
                labelStyle:
                    TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon:
                    Icon(Icons.phone, color: AppTheme.getTextColor(context)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return AppLocalizations.of(context)!.enterManagerMobile;
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.mustContainDigits;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // PASSWORD
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                labelStyle:
                    TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon:
                    Icon(Icons.lock, color: AppTheme.getTextColor(context)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? AppLocalizations.of(context)!.pleaseEnterPassword
                  : value.length < 6
                      ? AppLocalizations.of(context)!.passwordTooShort
                      : null,
            ),

            const SizedBox(height: 16),

            // CONFIRM PASSWORD
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              style: TextStyle(color: AppTheme.getTextColor(context)),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.confirmPassword,
                labelStyle:
                    TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: AppTheme.getTextColor(context)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                  onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppTheme.getBorderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getTextColor(context), width: 2),
                ),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? AppLocalizations.of(context)!.confirmPasswordHint
                  : value != _passwordController.text
                      ? AppLocalizations.of(context)!.passwordsDoNotMatch
                      : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(
                color: AppTheme.getBorderColor(context),
                width: 2,
              ),
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
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.getTextColor(context),
              foregroundColor: AppTheme.getBackgroundColor(context),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.complete,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: _isLoading
          ? null
          : () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: _isLoading
                ? AppTheme.getBorderColor(context)
                : AppTheme.getSecondaryTextColor(context),
          ),
          children: [
            TextSpan(text: AppLocalizations.of(context)!.alreadyHaveAccount),
            TextSpan(
              text: AppLocalizations.of(context)!.loginAction,
              style: TextStyle(
                color: _isLoading
                    ? AppTheme.getBorderColor(context)
                    : AppTheme.getTextColor(context),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleComplete() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final regProvider =
          Provider.of<RegistrationProvider>(context, listen: false);

      regProvider.setManagerInfo(
        _nameController.text,
        _mobileController.text,
        _passwordController.text,
      );

      final store = regProvider.buildStore()!;
      final branch = regProvider.buildBranch()!;
      final manager = regProvider.buildManager()!;

      final registrationData = RegistrationData(
        store: store,
        branch: branch,
        manager: manager,
        registeredAt: DateTime.now(),
      );

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.completeRegistration(registrationData);

      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        regProvider.reset();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle,
                    color: AppTheme.getTextColor(context)),
                const SizedBox(width: 12),
                Expanded(
                    child:
                        Text(AppLocalizations.of(context)!.registrationSuccess)),
              ],
            ),
            backgroundColor: AppTheme.getBackgroundColor(context),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }
}
