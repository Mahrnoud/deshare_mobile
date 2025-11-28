// ============================================================================
// FILE: lib/main.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/request_provider.dart';
import 'providers/history_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/registration_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DeShareApp());
}

class DeShareApp extends StatelessWidget {
  const DeShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..init()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..init()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()..init()),
        ChangeNotifierProxyProvider<SettingsProvider, RequestProvider>(
          create: (context) => RequestProvider(
            Provider.of<SettingsProvider>(context, listen: false),
          )..init(),
          update: (context, settings, previous) =>
          previous ?? RequestProvider(settings)..init(),
        ),
      ],
      child: MaterialApp(
        title: 'DeShare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}