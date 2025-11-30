// ============================================================================
// FILE: lib/screens/request_history_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/delivery_request.dart';
import '../providers/history_provider.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_chip.dart';
import 'request_details_screen.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  RequestStatus? _selectedFilter;

  final List<RequestStatus> _filterOptions = [
    RequestStatus.delivered,
    RequestStatus.expired,
    RequestStatus.cancelled,
  ];

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
              _buildFilterChips(),
              Expanded(
                child: Consumer<HistoryProvider>(
                  builder: (context, provider, _) {
                    final history = provider.getFilteredHistory(_selectedFilter);

                    if (history.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final request = history[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildHistoryCard(request),
                        );
                      },
                    );
                  },
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
            icon: Icon(Icons.arrow_back, color: AppTheme.getTextColor(context)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.requestHistory,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.allPastDeliveries,
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

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterChip(AppLocalizations.of(context)!.all, null),
          const SizedBox(width: 8),
          ..._filterOptions.map((status) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildFilterChip(_getStatusLabel(status), status),
              )),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, RequestStatus? status) {
    final isSelected = _selectedFilter == status;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.getSecondaryTextColor(context)
              : AppTheme.getTextColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFFFFF)
                : AppTheme.getBorderColor(context),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? const Color(0xFFFFFFFF)
                : AppTheme.getTextColor(context).withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(DeliveryRequest request) {
    return GlassCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RequestDetailsScreen(request: request),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!
                    .request(request.id.substring(request.id.length - 6)),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              StatusChip(status: request.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 14, color: AppTheme.getSecondaryTextColor(context)),
              const SizedBox(width: 8),
              Text(
                _formatDate(context, request.createdAt),
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.getTextColor(context).withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Color(0xFFFFFFFF)),
              const SizedBox(width: 8),
              Text(
                '${request.stops.length} stop(s)',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.getTextColor(context).withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.attach_money, size: 14, color: Color(0xFFFFFFFF)),
              const SizedBox(width: 8),
              Text(
                '\$${request.grandTotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.getTextColor(context).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.getTextColor(context).withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history,
                size: 64,
                color: AppTheme.getBorderColor(context),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _selectedFilter == null
                  ? AppLocalizations.of(context)!.noRequestsYet
                  : AppLocalizations.of(context)!.noRequestsOfType(
                      _getStatusLabel(_selectedFilter!).toLowerCase()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedFilter == null
                  ? AppLocalizations.of(context)!.createFirstRequest
                  : AppLocalizations.of(context)!.tryDifferentFilter,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextColor(context).withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.delivered:
        return AppLocalizations.of(context)!.delivered;
      case RequestStatus.expired:
        return AppLocalizations.of(context)!.expired;
      case RequestStatus.cancelled:
        return AppLocalizations.of(context)!.cancelled;
      default:
        return status.name;
    }
  }

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return AppLocalizations.of(context)!.todayAt(
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}');
    } else if (diff.inDays == 1) {
      return AppLocalizations.of(context)!.yesterdayAt(
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}');
    } else if (diff.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgoFormatted(diff.inDays);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
