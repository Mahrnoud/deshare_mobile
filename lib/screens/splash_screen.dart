// ============================================================================
// FILE: lib/screens/splash_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/onboarding_overlay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showOnboarding = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Initialize providers
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    await Future.wait([
      authProvider.init(),
      historyProvider.init(),
    ]);

    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _showOnboarding = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return Scaffold(
        body: OnboardingOverlay(
          onComplete: () {
            // OnboardingOverlay will handle navigation
          },
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF1A1F3A),
              Color(0xFF0A0E27),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00D9FF).withOpacity(0.3 * value),
                            Color(0xFFFF006E).withOpacity(0.3 * value),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.delivery_dining,
                        size: 80,
                        color: Color.lerp(
                          Colors.transparent,
                          const Color(0xFF00D9FF),
                          value,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF00D9FF), Color(0xFFFF006E)],
                      ).createShader(bounds),
                      child: const Text(
                        'DeShare',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: const Text(
                      'Streamline your delivery, share the load',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white60,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D9FF)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}