// ============================================================================
// FILE: lib/screens/reports_screen.dart (CLEANED)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import '../models/delivery_request.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';

enum ReportPeriod { daily, weekly, monthly }

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportPeriod _selectedPeriod = ReportPeriod.daily;
  DateTime _selectedDate = DateTime.now();

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
              _buildPeriodSelector(),
              _buildDateSelector(),
              Expanded(
                child: Consumer<HistoryProvider>(
                  builder: (context, provider, _) {
                    final stats = _calculateStats(provider.history);
                    return ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildStatsCard(stats),
                        const SizedBox(height: 16),
                        _buildDeliveredOrdersCard(stats),
                        const SizedBox(height: 16),
                        _buildExpiredOrdersCard(stats),
                        const SizedBox(height: 16),
                        _buildCancelledOrdersCard(stats),
                        const SizedBox(height: 16),
                        _buildSummaryCard(stats),
                      ],
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports & Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  'Track your delivery performance',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _buildPeriodButton('Daily', ReportPeriod.daily, Icons.today)),
          const SizedBox(width: 8),
          Expanded(child: _buildPeriodButton('Weekly', ReportPeriod.weekly, Icons.view_week)),
          const SizedBox(width: 8),
          Expanded(child: _buildPeriodButton('Monthly', ReportPeriod.monthly, Icons.calendar_month)),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String label, ReportPeriod period, IconData icon) {
    final isSelected = _selectedPeriod == period;

    return GestureDetector(
      onTap: () => setState(() => _selectedPeriod = period),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.getTextColor(context).withOpacity(0.2)
              : AppTheme.getTextColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFFFFF)
                : AppTheme.getBorderColor(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFFFFFF) : AppTheme.getSecondaryTextColor(context),
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFFFFFFFF) : AppTheme.getSecondaryTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _previousPeriod,
              icon: Icon(Icons.chevron_left, color: AppTheme.getTextColor(context)),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _getDateRangeText(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _canGoNext() ? _nextPeriod : null,
              icon: Icon(
                Icons.chevron_right,
                color: _canGoNext() ? AppTheme.getTextColor(context) : AppTheme.getBorderColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(ReportStats stats) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assessment, color: AppTheme.getTextColor(context), size: 20),
              const SizedBox(width: 8),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Requests',
                  '${stats.totalRequests}',
                  Icons.all_inbox,
                  AppTheme.getTextColor(context),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: AppTheme.getBorderColor(context),
              ),
              Expanded(
                child: _buildStatItem(
                  'Delivered',
                  '${stats.deliveredCount}',
                  Icons.check_circle,
                  AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Expired',
                  '${stats.expiredCount}',
                  Icons.timer_off,
                  AppTheme.getTextColor(context),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: AppTheme.getBorderColor(context),
              ),
              Expanded(
                child: _buildStatItem(
                  'Cancelled',
                  '${stats.cancelledCount}',
                  Icons.cancel,
                  AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.getBorderColor(context), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.getSecondaryTextColor(context),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // --- Delivered Orders ------------------------------------------------------

  Widget _buildDeliveredOrdersCard(ReportStats stats) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.getTextColor(context).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.check_circle, color: AppTheme.getTextColor(context), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Delivered Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Orders',
            '${stats.deliveredCount}',
            Icons.shopping_bag,
            AppTheme.getTextColor(context),
          ),
          Divider(color: AppTheme.getBorderColor(context), height: 24),
          _buildReportRow(
            'Orders Amount',
            '\$${stats.deliveredOrdersAmount.toStringAsFixed(2)}',
            Icons.attach_money,
            AppTheme.getTextColor(context),
            subtitle: 'Excluding delivery fees',
          ),
          Divider(color: AppTheme.getBorderColor(context), height: 24),
          _buildReportRow(
            'Delivery Fees',
            '\$${stats.deliveredDeliveryFees.toStringAsFixed(2)}',
            Icons.local_shipping,
            AppTheme.getTextColor(context),
            subtitle: 'Total fees collected',
          ),
        ],
      ),
    );
  }

  // --- Expired Orders --------------------------------------------------------

  Widget _buildExpiredOrdersCard(ReportStats stats) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.getTextColor(context).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.timer_off, color: AppTheme.getTextColor(context), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Expired Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Expired',
            '${stats.expiredCount}',
            Icons.timer_off_outlined,
            AppTheme.getTextColor(context),
            subtitle: stats.expiredCount > 0
                ? '${((stats.expiredCount / stats.totalRequests) * 100).toStringAsFixed(1)}% of total'
                : 'No expired requests',
          ),
        ],
      ),
    );
  }

  // --- Cancelled Orders ------------------------------------------------------

  Widget _buildCancelledOrdersCard(ReportStats stats) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.getTextColor(context).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.cancel, color: AppTheme.getTextColor(context), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Cancelled Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Cancelled',
            '${stats.cancelledCount}',
            Icons.cancel_outlined,
            AppTheme.getTextColor(context),
            subtitle: stats.cancelledCount > 0
                ? '${((stats.cancelledCount / stats.totalRequests) * 100).toStringAsFixed(1)}% of total'
                : 'Great job!',
          ),
        ],
      ),
    );
  }

  // --- Summary ---------------------------------------------------------------

  Widget _buildSummaryCard(ReportStats stats) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.getTextColor(context).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.summarize, color: AppTheme.getTextColor(context), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Financial Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.getTextColor(context).withOpacity(0.1),
                  AppTheme.getTextColor(context).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.getTextColor(context).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                _summaryRow(
                  'Orders Amount',
                  '\$${stats.deliveredOrdersAmount.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                _summaryRow(
                  'Delivery Fees',
                  '\$${stats.deliveredDeliveryFees.toStringAsFixed(2)}',
                ),
                Divider(color: AppTheme.getBorderColor(context), height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Revenue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    Text(
                      '\$${stats.totalRevenue.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: AppTheme.getTextColor(context).withOpacity(0.54)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Based on ${stats.deliveredCount} delivered order${stats.deliveredCount != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextColor(context).withOpacity(0.54),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.getTextColor(context).withOpacity(0.70),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildReportRow(
      String label,
      String value,
      IconData icon,
      Color color, {
        String? subtitle,
      }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.getTextColor(context).withOpacity(0.70),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.getTextColor(context).withOpacity(0.54),
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // ==========================================================================

  ReportStats _calculateStats(List<DeliveryRequest> allRequests) {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    switch (_selectedPeriod) {
      case ReportPeriod.daily:
        startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
        endDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 23, 59, 59);
        break;

      case ReportPeriod.weekly:
        final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        startDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
        endDate = startDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
        break;

      case ReportPeriod.monthly:
        startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
        endDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 0, 23, 59, 59);
        break;
    }

    final filteredRequests = allRequests.where((request) {
      return request.createdAt.isAfter(startDate) &&
          request.createdAt.isBefore(endDate);
    }).toList();

    final delivered = filteredRequests.where((r) => r.status == RequestStatus.delivered).toList();
    final expired = filteredRequests.where((r) => r.status == RequestStatus.expired).toList();
    final cancelled = filteredRequests.where((r) => r.status == RequestStatus.cancelled).toList();

    double ordersAmount = 0;
    double deliveryFees = 0;

    for (final r in delivered) {
      ordersAmount += r.subtotalOrders;
      deliveryFees += r.totalDeliveryFees;
    }

    return ReportStats(
      totalRequests: filteredRequests.length,
      deliveredCount: delivered.length,
      expiredCount: expired.length,
      cancelledCount: cancelled.length,
      deliveredOrdersAmount: ordersAmount,
      deliveredDeliveryFees: deliveryFees,
      totalRevenue: ordersAmount + deliveryFees,
    );
  }

  String _getDateRangeText() {
    switch (_selectedPeriod) {
      case ReportPeriod.daily:
        return _formatDate(_selectedDate);

      case ReportPeriod.weekly:
        final start = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        final end = start.add(const Duration(days: 6));
        return '${_formatDate(start)} - ${_formatDate(end)}';

      case ReportPeriod.monthly:
        return '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}';
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _previousPeriod() {
    setState(() {
      switch (_selectedPeriod) {
        case ReportPeriod.daily:
          _selectedDate = _selectedDate.subtract(const Duration(days: 1));
          break;
        case ReportPeriod.weekly:
          _selectedDate = _selectedDate.subtract(const Duration(days: 7));
          break;
        case ReportPeriod.monthly:
          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
          break;
      }
    });
  }

  void _nextPeriod() {
    setState(() {
      switch (_selectedPeriod) {
        case ReportPeriod.daily:
          _selectedDate = _selectedDate.add(const Duration(days: 1));
          break;
        case ReportPeriod.weekly:
          _selectedDate = _selectedDate.add(const Duration(days: 7));
          break;
        case ReportPeriod.monthly:
          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
          break;
      }
    });
  }

  bool _canGoNext() {
    final now = DateTime.now();
    switch (_selectedPeriod) {
      case ReportPeriod.daily:
        return _selectedDate.isBefore(DateTime(now.year, now.month, now.day));

      case ReportPeriod.weekly:
        final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        final currentStart = now.subtract(Duration(days: now.weekday - 1));
        return weekStart.isBefore(currentStart);

      case ReportPeriod.monthly:
        return _selectedDate.isBefore(DateTime(now.year, now.month));
    }
  }
}

// ============================================================================

class ReportStats {
  final int totalRequests;
  final int deliveredCount;
  final int expiredCount;
  final int cancelledCount;
  final double deliveredOrdersAmount;
  final double deliveredDeliveryFees;
  final double totalRevenue;

  ReportStats({
    required this.totalRequests,
    required this.deliveredCount,
    required this.expiredCount,
    required this.cancelledCount,
    required this.deliveredOrdersAmount,
    required this.deliveredDeliveryFees,
    required this.totalRevenue,
  });
}
