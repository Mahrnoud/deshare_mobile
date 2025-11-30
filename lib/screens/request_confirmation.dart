// ============================================================================
// FILE: lib/screens/request_confirmation.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/delivery_request.dart';
import '../models/delivery_stop.dart';
import '../providers/request_provider.dart';
import '../providers/history_provider.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';

class RequestConfirmationScreen extends StatelessWidget {
  final List<DeliveryStop> stops;

  const RequestConfirmationScreen({super.key, required this.stops});

  double get _subtotal => stops.fold(0, (sum, s) => sum + s.orderAmount);
  double get _totalFees => stops.fold(0, (sum, s) => sum + s.deliveryFee);
  double get _grandTotal => _subtotal + _totalFees;

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
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    _buildInfoCard(context),
                    SizedBox(height: 16),
                    ..._buildStopCards(context),
                    SizedBox(height: 16),
                    _buildSummaryCard(context),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildActionButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppTheme.getTextColor(context)),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.confirmRequest,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.reviewBeforeSending,
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

  Widget _buildInfoCard(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.info_outline,
              color: AppTheme.getTextColor(context),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.infoMessage,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextColor(context).withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStopCards(BuildContext context) {
    return stops.asMap().entries.map((entry) {
      final index = entry.key;
      final stop = entry.value;

      return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.getTextColor(context).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: AppTheme.getTextColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.stop(index + 1),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: AppTheme.getTextColor(context)),
                  SizedBox(width: 8),
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
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shopping_bag, size: 16, color: AppTheme.getTextColor(context)),
                      SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.order,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.getTextColor(context).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_shipping, size: 16, color: AppTheme.getTextColor(context)),
                      SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.feeWithAmount,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.getTextColor(context).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (stop.notes.isNotEmpty) ...[
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.getTextColor(context).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.note, size: 14, color: AppTheme.getTextColor(context).withOpacity(0.54)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          stop.notes,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.getTextColor(context).withOpacity(0.54),
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
      );
    }).toList();
  }

  Widget _buildSummaryCard(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.paymentSummary,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          SizedBox(height: 16),
          _buildSummaryRow(
              context, AppLocalizations.of(context)!.ordersSubtotal, _subtotal),
          SizedBox(height: 8),
          _buildSummaryRow(
              context, AppLocalizations.of(context)!.deliveryFees, _totalFees),
          Divider(
            color: AppTheme.getBorderColor(context),
            height: 24,
          ),
          _buildSummaryRow(
              context, AppLocalizations.of(context)!.grandTotal, _grandTotal,
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
      BuildContext context,
      String label,
      double amount, {
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
            color: AppTheme.getTextColor(context).withOpacity(0.7),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              margin: EdgeInsets.only(right: 8),
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppTheme.getBorderColor(context),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.edit,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 56,
              margin: EdgeInsets.only(left: 8),
              child: ElevatedButton(
                onPressed: () => _confirmRequest(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getTextColor(context),
                  foregroundColor: AppTheme.getBackgroundColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: AppTheme.getTextColor(context).withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, size: 20),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.sendRequest,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRequest(BuildContext context) async {
    final request = DeliveryRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      status: RequestStatus.searching,
      stops: stops,
      timeline: [],
    );

    final requestProvider = Provider.of<RequestProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    await requestProvider.createRequest(request);
    await historyProvider.addToHistory(request);

    if (context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: AppTheme.getTextColor(context)),
              SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.requestSent,
                style: TextStyle(color: AppTheme.getTextColor(context)),
              ),
            ],
          ),
          backgroundColor: AppTheme.getBorderColor(context),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}
