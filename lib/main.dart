// ============================================================================
// FILE: lib/main.dart (UPDATED)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'providers/request_provider.dart';
import 'providers/history_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/registration_provider.dart';
import '../l10n/app_localizations.dart';
import 'providers/theme_provider.dart'; // NEW
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
        ChangeNotifierProvider(create: (_) => LanguageProvider()..fetchLocale()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()), // NEW
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
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return Consumer<LanguageProvider>(
            builder: (context, languageProvider, _) {
              return MaterialApp(
                title: 'DeShare',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme, // Light theme
                darkTheme: AppTheme.darkTheme, // Dark theme
                themeMode: themeProvider.themeMode, // Use provider's theme mode
                locale: languageProvider.appLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}