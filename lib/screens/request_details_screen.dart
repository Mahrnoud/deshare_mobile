// ============================================================================
// FILE: lib/screens/request_details_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../models/delivery_request.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_chip.dart';
import 'request_confirmation.dart';

class RequestDetailsScreen extends StatelessWidget {
  final DeliveryRequest request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.getBackgroundColor(context),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildStatusCard(context),
                    const SizedBox(height: 16),
                    _buildInfoCard(context),
                    const SizedBox(height: 16),
                    _buildStopsCard(context),
                    const SizedBox(height: 16),
                    _buildSummaryCard(context),
                    if (request.timeline.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildTimelineCard(context),
                    ],
                    if (request.status == RequestStatus.expired ||
                        request.status == RequestStatus.cancelled) ...[
                      const SizedBox(height: 16),
                      _buildReRequestButton(context),
                    ],
                    const SizedBox(height: 100),
                  ],
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
                  'Request #${request.id.substring(request.id.length - 6)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  _formatDateTime(request.createdAt),
                  style: TextStyle(fontSize: 14, color: AppTheme.getSecondaryTextColor(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Status',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getTextColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          StatusChip(status: request.status),
          if (request.acceptedDriverId != null) ...[
            const SizedBox(height: 16),
            Divider(color: AppTheme.getTextColor(context)),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.getTextColor(context).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppTheme.getTextColor(context),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Driver',
                        style: TextStyle(fontSize: 12, color: AppTheme.getTextColor(context)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request.offers
                            .firstWhere((o) => o.id == request.acceptedOfferId)
                            .driverName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.getTextColor(context),
                        ),
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.star,
                            size: 14,
                            color: AppTheme.getTextColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            request.offers
                                .firstWhere(
                                  (o) => o.id == request.acceptedOfferId,
                                )
                                .driverRating
                                .toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.getTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Request ID',
                  style: TextStyle(fontSize: 12, color: AppTheme.getTextColor(context)),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${request.id.substring(request.id.length - 6)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: AppTheme.getBorderColor(context)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Created',
                  style: TextStyle(fontSize: 12, color: AppTheme.getTextColor(context)),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(request.createdAt),
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopsCard(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Delivery Stops',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          ...request.stops.asMap().entries.map((entry) {
            final index = entry.key;
            final stop = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.getTextColor(context).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: AppTheme.getTextColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppTheme.getTextColor(context),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                stop.addressText,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getTextColor(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.getTextColor(context).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Icon(
                                    Icons.shopping_bag,
                                    size: 12,
                                    color: AppTheme.getTextColor(context),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '\$${stop.orderAmount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.getTextColor(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.getTextColor(context).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Icon(
                                    Icons.local_shipping,
                                    size: 12,
                                    color: AppTheme.getTextColor(context),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '\$${stop.deliveryFee.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.getTextColor(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (stop.notes.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.getTextColor(context).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.note,
                                  size: 12,
                                  color: AppTheme.getTextColor(context),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    stop.notes,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.getTextColor(context),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            context,
            'Orders Subtotal',
            request.subtotalOrders,
            AppTheme.getTextColor(context),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(context,
            'Delivery Fees',
            request.totalDeliveryFees,
            AppTheme.getTextColor(context),
          ),
          const Divider(color: Colors.white, height: 24),
          _buildSummaryRow(
            context,
            'Grand Total',
            request.grandTotal,
            AppTheme.getTextColor(context),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
      BuildContext context,
    String label,
    double amount,
    Color color, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: AppTheme.getTextColor(context),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineCard(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Timeline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          ...request.timeline.map((event) {
            final parts = event.split('|');
            final time = DateTime.parse(parts[0]);
            final message = parts[1];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.getBorderColor(context),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTextColor(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(time),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.getTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildReRequestButton(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
           Icon(Icons.refresh, size: 32, color: AppTheme.getTextColor(context)),
          const SizedBox(height: 12),
          Text(
            'Request Again?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Use the same delivery stops for a new request',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextColor(context).withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _reRequestDelivery(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.getTextColor(context),
              foregroundColor: AppTheme.getBackgroundColor(context),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Create New Request',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _reRequestDelivery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RequestConfirmationScreen(stops: request.stops),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
