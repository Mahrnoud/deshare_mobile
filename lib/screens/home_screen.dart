// ============================================================================
// FILE: lib/screens/home_screen.dart (UPDATED - removed settings from quick actions)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/request_provider.dart';
import '../providers/history_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/auth_provider.dart';
import '../models/delivery_request.dart';
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
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
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
              const Text(
                'DeShare',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final user = authProvider.currentUser;
                  return Text(
                    user != null ? 'Welcome, ${user['name']}' : 'Store Manager',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
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
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout, color: Colors.white),
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
                const Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: Color(0xFFffffff),
                ),
                const SizedBox(height: 12),
                const Text(
                  'No Active Deliveries',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Create a new delivery request to get started',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
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
                  const Text(
                    'Active Request',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  StatusChip(status: request.status),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Request #${request.id.substring(request.id.length - 6)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Color(0xFFffffff)),
                  const SizedBox(width: 4),
                  Text(
                    '${request.stops.length} stop(s)',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.attach_money, size: 16, color: Color(0xFFffffff)),
                  const SizedBox(width: 4),
                  Text(
                    '\$${request.grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (request.status == RequestStatus.offerReceived)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD600).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFFD600)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer, size: 16, color: Color(0xFFFFD600)),
                      const SizedBox(width: 8),
                      Text(
                        '${request.offers.length} offer(s) available',
                        style: const TextStyle(
                          color: Color(0xFFFFD600),
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
                    color: Colors.orange,
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // elevation: 8,
        // shadowColor: const Color(0xFFffffff).withOpacity(0.5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 28,),
          SizedBox(width: 12),
          Text(
            'Create New Delivery Request',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
                child: const Column(
                  children: [
                    Icon(Icons.history, size: 32, color: Color(0xFFffffff)),
                    SizedBox(height: 8),
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
                child: const Column(
                  children: [
                    Icon(Icons.analytics, size: 32, color: Color(0xFFffffff)),
                    SizedBox(height: 8),
                    Text(
                      'Reports',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Debug Settings', style: TextStyle(color: Colors.white)),
        content: Consumer<SettingsProvider>(
          builder: (context, settings, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Fast Timers', style: TextStyle(color: Colors.white)),
                subtitle: const Text(
                  '10min → 1min, 30s → 5s',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
                value: settings.fastTimers,
                onChanged: settings.setFastTimers,
                activeColor: const Color(0xFFffffff),
              ),
              SwitchListTile(
                title: const Text('Force No Drivers', style: TextStyle(color: Colors.white)),
                subtitle: const Text(
                  'Simulate no available drivers',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
                value: settings.forceNoDrivers,
                onChanged: settings.setForceNoDrivers,
                activeColor: const Color(0xFFffffff),
              ),
              const Divider(color: Colors.white30),
              ListTile(
                leading: const Icon(Icons.data_object, color: Color(0xFFFFD600)),
                title: const Text('Seed Fake Data', style: TextStyle(color: Colors.white)),
                onTap: () {
                  history.seedFakeData();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added 5 fake requests')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Color(0xFFFF006E)),
                title: const Text('Clear All Data', style: TextStyle(color: Colors.white)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF000000),
                      title: const Text('Confirm', style: TextStyle(color: Colors.white)),
                      content: const Text(
                        'This will clear all requests and settings',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            settings.clearAllData();
                            history.clearHistory();
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                          },
                          child: const Text('Clear', style: TextStyle(color: Colors.red)),
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
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              }
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Color(0xFFFF006E)),
            ),
          ),
        ],
      ),
    );
  }
}