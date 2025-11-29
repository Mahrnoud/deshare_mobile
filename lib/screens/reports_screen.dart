// ============================================================================
// FILE: lib/screens/reports_screen.dart (UPDATED)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import '../models/delivery_request.dart';
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
        decoration: const BoxDecoration(
          color: Color(0xFF000000)
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports & Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Track your delivery performance',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
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
          Expanded(
            child: _buildPeriodButton(
              'Daily',
              ReportPeriod.daily,
              Icons.today,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildPeriodButton(
              'Weekly',
              ReportPeriod.weekly,
              Icons.view_week,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildPeriodButton(
              'Monthly',
              ReportPeriod.monthly,
              Icons.calendar_month,
            ),
          ),
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
              ? const Color(0xFFffffff).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFffffff) : Colors.white30,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFffffff) : Colors.white60,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFFffffff) : Colors.white60,
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
              icon: const Icon(Icons.chevron_left, color: Color(0xFFffffff)),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _getDateRangeText(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _canGoNext() ? _nextPeriod : null,
              icon: Icon(
                Icons.chevron_right,
                color: _canGoNext() ? const Color(0xFFffffff) : Colors.white30,
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
          const Row(
            children: [
              Icon(Icons.assessment, color: Color(0xFFffffff), size: 20),
              SizedBox(width: 8),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  const Color(0xFFffffff),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white30,
              ),
              Expanded(
                child: _buildStatItem(
                  'Delivered',
                  '${stats.deliveredCount}',
                  Icons.check_circle,
                  const Color(0xFFffffff),
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
                  const Color(0xFFffffff),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white30,
              ),
              Expanded(
                child: _buildStatItem(
                  'Cancelled',
                  '${stats.cancelledCount}',
                  Icons.cancel,
                  const Color(0xFFffffff),
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
        Icon(icon, color: color, size: 24),
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
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

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
                  color: const Color(0xFFffffff).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFFffffff),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Delivered Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Orders',
            '${stats.deliveredCount}',
            Icons.shopping_bag,
            const Color(0xFFffffff),
          ),
          const Divider(color: Colors.white30, height: 24),
          _buildReportRow(
            'Orders Amount',
            '\$${stats.deliveredOrdersAmount.toStringAsFixed(2)}',
            Icons.attach_money,
            const Color(0xFFffffff),
            subtitle: 'Excluding delivery fees',
          ),
          const Divider(color: Colors.white30, height: 24),
          _buildReportRow(
            'Delivery Fees',
            '\$${stats.deliveredDeliveryFees.toStringAsFixed(2)}',
            Icons.local_shipping,
            const Color(0xFFffffff),
            subtitle: 'Total fees collected',
          ),
        ],
      ),
    );
  }

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
                  color: const Color(0xFFffffff).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.timer_off,
                  color: Color(0xFFffffff),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Expired Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Expired',
            '${stats.expiredCount}',
            Icons.timer_off_outlined,
            const Color(0xFFffffff),
            subtitle: stats.expiredCount > 0
                ? '${((stats.expiredCount / stats.totalRequests) * 100).toStringAsFixed(1)}% of total'
                : 'No expired requests',
          ),
        ],
      ),
    );
  }

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
                  color: const Color(0xFFffffff).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.cancel,
                  color: Color(0xFFffffff),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Cancelled Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildReportRow(
            'Total Cancelled',
            '${stats.cancelledCount}',
            Icons.cancel_outlined,
            const Color(0xFFffffff),
            subtitle: stats.cancelledCount > 0
                ? '${((stats.cancelledCount / stats.totalRequests) * 100).toStringAsFixed(1)}% of total'
                : 'Great job!',
          ),
        ],
      ),
    );
  }

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
                  color: const Color(0xFFffffff).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.summarize,
                  color: Color(0xFFffffff),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Financial Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFffffff).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFffffff).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Orders Amount',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '\$${stats.deliveredOrdersAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery Fees',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '\$${stats.deliveredDeliveryFees.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white30, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Revenue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\$${stats.totalRevenue.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff),
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
              const Icon(Icons.info_outline, size: 14, color: Colors.white54),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Based on ${stats.deliveredCount} delivered order${stats.deliveredCount != 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white54,
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
      return request.createdAt.isAfter(startDate) && request.createdAt.isBefore(endDate);
    }).toList();

    final deliveredRequests = filteredRequests
        .where((r) => r.status == RequestStatus.delivered)
        .toList();

    final expiredRequests = filteredRequests
        .where((r) => r.status == RequestStatus.expired)
        .toList();

    final cancelledRequests = filteredRequests
        .where((r) => r.status == RequestStatus.cancelled)
        .toList();

    double totalOrdersAmount = 0;
    double totalDeliveryFees = 0;

    for (final request in deliveredRequests) {
      totalOrdersAmount += request.subtotalOrders;
      totalDeliveryFees += request.totalDeliveryFees;
    }

    return ReportStats(
      totalRequests: filteredRequests.length,
      deliveredCount: deliveredRequests.length,
      expiredCount: expiredRequests.length,
      cancelledCount: cancelledRequests.length,
      deliveredOrdersAmount: totalOrdersAmount,
      deliveredDeliveryFees: totalDeliveryFees,
      totalRevenue: totalOrdersAmount + totalDeliveryFees,
    );
  }

  String _getDateRangeText() {
    switch (_selectedPeriod) {
      case ReportPeriod.daily:
        return _formatDate(_selectedDate);
      case ReportPeriod.weekly:
        final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return '${_formatDate(weekStart)} - ${_formatDate(weekEnd)}';
      case ReportPeriod.monthly:
        return _getMonthName(_selectedDate.month) + ' ${_selectedDate.year}';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

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
        final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
        return weekStart.isBefore(currentWeekStart);
      case ReportPeriod.monthly:
        return _selectedDate.isBefore(DateTime(now.year, now.month));
    }
  }
}

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