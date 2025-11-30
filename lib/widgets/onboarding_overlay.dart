// ============================================================================
// FILE: lib/widgets/onboarding_overlay.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';
import 'glass_card.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/registration_step1_screen.dart';
import '../screens/home_screen.dart';

class OnboardingOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingOverlay({super.key, required this.onComplete});

  @override
  State<OnboardingOverlay> createState() => _OnboardingOverlayState();
}

class _OnboardingOverlayState extends State<OnboardingOverlay> {
  int _currentPage = 0;
  final _pageController = PageController();

  final _pages = [
    _OnboardingPage(
      icon: Icons.add_location_alt,
      title: 'Multi-Stop Delivery',
      description: 'Create delivery requests with multiple customer addresses. Use autocomplete to find addresses quickly.',
    ),
    _OnboardingPage(
      icon: Icons.local_offer,
      title: 'Receive Offers',
      description: 'Nearby drivers will send offers. Each offer is valid for 30 seconds. Accept the best one!',
    ),
    _OnboardingPage(
      icon: Icons.delivery_dining,
      title: 'Track Delivery',
      description: 'Monitor your delivery in real-time from pickup to completion. All requests are saved in history.',
    ),
  ];

  void _handleGetStarted() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Widget nextScreen;
    if (authProvider.isLoggedIn) {
      // User is logged in -> go to home
      nextScreen = const HomeScreen();
    } else if (authProvider.isRegistered) {
      // User is registered but not logged in -> go to login
      nextScreen = const LoginScreen();
    } else {
      // User is not registered -> go to registration
      nextScreen = const RegistrationStep1Screen();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getBackgroundColor(context),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _pages[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppTheme.getTextColor(context)
                              : AppTheme.getBorderColor(context),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: AppTheme.getBorderColor(context)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Back'),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _currentPage == _pages.length - 1
                              ? _handleGetStarted
                              : () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.getTextColor(context),
                            foregroundColor: AppTheme.getBackgroundColor(context),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getTextColor(context).withOpacity(0.1), // <-- fixed color here
            ),
            child: Icon(icon, size: 80, color: AppTheme.getTextColor(context)),
          ),
          const SizedBox(height: 48),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.getTextColor(context),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}