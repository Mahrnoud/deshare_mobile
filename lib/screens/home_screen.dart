// ============================================================================
// FILE: lib/screens/home_screen.dart (UPDATED - removed settings from quick actions)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/request_provider.dart';
import '../providers/language_provider.dart';
import '../providers/history_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/auth_provider.dart';
import '../models/delivery_request.dart';
import '../providers/theme_provider.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_chip.dart';
import '../widgets/countdown_timer.dart';
import 'create_request_screen.dart';
import 'active_request_screen.dart';
import 'request_history_screen.dart';
import 'reports_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildActiveRequestCard(context),
                      const SizedBox(height: 24),
                      _buildCreateButton(context),
                      const SizedBox(height: 24),
                      _buildQuickActions(context),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'DeShare',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final user = authProvider.currentUser;
                  return Text(
                    user != null
                        ? AppLocalizations.of(context)!.welcome(user['name'])
                        : AppLocalizations.of(context)!.storeManager,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _showSettingsDialog(context),
                icon: Icon(Icons.settings, color: AppTheme.getTextColor(context)),
              ),
              IconButton(
                onPressed: () => _showLogoutDialog(context),
                icon: Icon(Icons.logout, color: AppTheme.getTextColor(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRequestCard(BuildContext context) {
    return Consumer<RequestProvider>(
      builder: (context, provider, _) {
        final request = provider.activeRequest;

        if (request == null || !request.isActive) {
          return GlassCard(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: AppTheme.getTextColor(context),
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.noActiveDeliveries,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!
                      .createNewDeliveryRequestToGetStarted,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextColor(context).withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return GlassCard(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ActiveRequestScreen(request: request),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.activeRequest,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.getSecondaryTextColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  StatusChip(status: request.status),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Request #${request.id.substring(request.id.length - 6)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                   Icon(Icons.location_on, size: 16, color: AppTheme.getTextColor(context)),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.stops(request.stops.length),
                    style:  TextStyle(color: AppTheme.getTextColor(context)),
                  ),
                  const SizedBox(width: 16),
                   Icon(Icons.attach_money, size: 16, color: AppTheme.getTextColor(context)),
                  const SizedBox(width: 4),
                  Text(
                    '\$${request.grandTotal.toStringAsFixed(2)}',
                    style: TextStyle(color: AppTheme.getTextColor(context)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (request.status == RequestStatus.offerReceived)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.accentYellow),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer, size: 16, color: AppTheme.accentYellow),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.offersAvailable(request.offers.length),
                        style: TextStyle(
                          color: AppTheme.getTextColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (request.remainingTime != null &&
                  request.status != RequestStatus.accepted)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CountdownTimer(
                    duration: request.remainingTime!,
                    color: AppTheme.accentOrange,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreateRequestScreen()),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.getTextColor(context),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // elevation: 8,
        // shadowColor: const Color(0xFFffffff).withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 28, color: AppTheme.getBackgroundColor(context),),
          SizedBox(width: 12),
          Text(
            AppLocalizations.of(context)!.createNewDeliveryRequest,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getBackgroundColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.quickActions,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextColor(context),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GlassCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RequestHistoryScreen()),
                ),
                child: Column(
                  children: [
                    Icon(Icons.history, size: 32, color: AppTheme.getTextColor(context)),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.history,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlassCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                ),
                child: Column(
                  children: [
                    Icon(Icons.analytics, size: 32, color: AppTheme.getTextColor(context)),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.reports,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  void _showSettingsDialog(BuildContext context) {
    final history = Provider.of<HistoryProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getSurfaceColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: AppTheme.getTextColor(context)),
        ),
        content: Consumer2<SettingsProvider, ThemeProvider>(
          builder: (context, settings, theme, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Theme Toggle
              SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.darkMode,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.toggleTheme,
                  style: TextStyle(
                    color: AppTheme.getSecondaryTextColor(context),
                    fontSize: 12,
                  ),
                ),
                value: theme.isDarkMode,
                onChanged: (value) {
                  theme.toggleTheme();
                },
                activeColor: AppTheme.getAccentColor(context),
              ),
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, _) => SwitchListTile(
                  title: Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(color: AppTheme.getTextColor(context)),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.toggleLanguage,
                    style: TextStyle(
                      color: AppTheme.getSecondaryTextColor(context),
                      fontSize: 12,
                    ),
                  ),
                  value: languageProvider.appLocale == const Locale('ar'),
                  onChanged: (value) {
                    if (value) {
                      languageProvider.changeLanguage(const Locale('ar'));
                    } else {
                      languageProvider.changeLanguage(const Locale('en'));
                    }
                  },
                  activeColor: AppTheme.getAccentColor(context),
                ),
              ),
              const Divider(),
              // Debug Settings Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  AppLocalizations.of(context)!.debugSettings,
                  style: TextStyle(
                    color: AppTheme.getSecondaryTextColor(context),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.fastTimers,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.fastTimersDescription,
                  style: TextStyle(
                    color: AppTheme.getSecondaryTextColor(context),
                    fontSize: 12,
                  ),
                ),
                value: settings.fastTimers,
                onChanged: settings.setFastTimers,
                activeColor: AppTheme.getAccentColor(context),
              ),
              SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.forceNoDrivers,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.forceNoDriversDescription,
                  style: TextStyle(
                    color: AppTheme.getSecondaryTextColor(context),
                    fontSize: 12,
                  ),
                ),
                value: settings.forceNoDrivers,
                onChanged: settings.setForceNoDrivers,
                activeColor: AppTheme.getAccentColor(context),
              ),
              Divider(color: AppTheme.getBorderColor(context)),
              ListTile(
                leading: Icon(
                  Icons.data_object,
                  color: AppTheme.accentYellow,
                ),
                title: Text(
                  AppLocalizations.of(context)!.seedFakeData,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
                onTap: () {
                  history.seedFakeData();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.addedFakeRequests),
                      backgroundColor: AppTheme.getSurfaceColor(context),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_forever,
                  color: AppTheme.accentRed,
                ),
                title: Text(
                  AppLocalizations.of(context)!.clearAllData,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: AppTheme.getSurfaceColor(context),
                      title: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: TextStyle(color: AppTheme.getTextColor(context)),
                      ),
                      content: Text(
                        AppLocalizations.of(context)!.confirmClearAllData,
                        style: TextStyle(
                          color: AppTheme.getSecondaryTextColor(context),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            settings.clearAllData();
                            history.clearHistory();
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.clear,
                            style: TextStyle(color: AppTheme.accentRed),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.getBackgroundColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          AppLocalizations.of(context)!.logout,
          style: TextStyle(color: AppTheme.getTextColor(context)),
        ),
        content: Text(
          AppLocalizations.of(context)!.confirmLogout,
          style: TextStyle(color: AppTheme.getTextColor(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: Text(
              AppLocalizations.of(context)!.logout,
              style: const TextStyle(color: Color(0xFFFF006E)),
            ),
          ),
        ],
      ),
    );
  }
}