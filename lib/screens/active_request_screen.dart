// ============================================================================
// FILE: lib/screens/active_request_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/delivery_request.dart';
import '../providers/request_provider.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_chip.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/offer_card.dart';

class ActiveRequestScreen extends StatelessWidget {
  final DeliveryRequest request;

  const ActiveRequestScreen({super.key, required this.request});

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
                child: Consumer<RequestProvider>(
                  builder: (context, provider, _) {
                    final activeRequest = provider.activeRequest;
                    if (activeRequest == null) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.requestNotFound,
                          style: TextStyle(
                            color: AppTheme.getTextColor(context).withOpacity(0.70),
                          ),
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildStatusCard(context, activeRequest),
                        const SizedBox(height: 16),
                        if (activeRequest.status == RequestStatus.searching ||
                            activeRequest.status == RequestStatus.offerReceived)
                          _buildTimerCard(context, activeRequest),
                        const SizedBox(height: 16),
                        if (activeRequest.offers.isNotEmpty &&
                            activeRequest.status == RequestStatus.offerReceived)
                          ..._buildOffersList(context, activeRequest),
                        if (activeRequest.status == RequestStatus.searching &&
                            activeRequest.offers.isEmpty)
                          _buildSearchingCard(context),
                        const SizedBox(height: 16),
                        if (activeRequest.status == RequestStatus.expired)
                          _buildExpiredCard(context, activeRequest),
                        const SizedBox(height: 10),
                        _buildStopsCard(context, activeRequest),
                        const SizedBox(height: 16),
                        _buildTimelineCard(context, activeRequest),
                        const SizedBox(height: 100),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActions(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

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
                  AppLocalizations.of(context)!
                      .request(request.id.substring(request.id.length - 6)),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  _getTimeAgo(context, request.createdAt),
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

  // ---------------------------------------------------------------------------
  // Status Card
  // ---------------------------------------------------------------------------

  Widget _buildStatusCard(BuildContext context, DeliveryRequest request) {
    return GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.currentStatus,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getSecondaryTextColor(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              StatusChip(status: request.status),
            ],
          ),
          if (request.acceptedDriverId != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!.driver,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
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
              ],
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Timer Card
  // ---------------------------------------------------------------------------

  Widget _buildTimerCard(BuildContext context, DeliveryRequest request) {
    if (request.remainingTime == null) return const SizedBox.shrink();

    return GlassCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.timer, color: AppTheme.getTextColor(context), size: 28),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.requestExpiresIn,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.getTextColor(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CountdownTimer(
            duration: request.remainingTime!,
            color: AppTheme.getTextColor(context),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Offers List
  // ---------------------------------------------------------------------------

  List<Widget> _buildOffersList(BuildContext context, DeliveryRequest request) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          AppLocalizations.of(context)!.availableOffers,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
      ),
      ...request.offers.map(
            (offer) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OfferCard(
            offer: offer,
            onAccept: () => _acceptOffer(context, offer),
          ),
        ),
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Searching Card
  // ---------------------------------------------------------------------------

  Widget _buildSearchingCard(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              size: 48,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.searchingForDrivers,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.notifyingDrivers,
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

  // ---------------------------------------------------------------------------
  // Expired Card
  // ---------------------------------------------------------------------------

  Widget _buildExpiredCard(BuildContext context, DeliveryRequest request) {
    return GlassCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getTextColor(context).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.timer_off,
              size: 48,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.requestExpired,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.noDriversAccepted,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextColor(context).withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _retryRequest(context, request),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.getTextColor(context),
              foregroundColor: AppTheme.getBackgroundColor(context),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.refresh),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.retryRequest,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Stops Card
  // ---------------------------------------------------------------------------

  Widget _buildStopsCard(BuildContext context, DeliveryRequest request) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.deliveryStops,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          ...request.stops.asMap().entries.map(
                (entry) {
              final index = entry.key;
              final stop = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
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
                          Text(
                            stop.addressText,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.getTextColor(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${stop.orderAmount.toStringAsFixed(2)} + \$${stop.deliveryFee.toStringAsFixed(2)} ${AppLocalizations.of(context)!.fee}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.getSecondaryTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(color: AppTheme.getBorderColor(context), height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.grandTotal,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                '\$${request.grandTotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Timeline Card
  // ---------------------------------------------------------------------------

  Widget _buildTimelineCard(BuildContext context, DeliveryRequest request) {
    if (request.timeline.isEmpty) return const SizedBox.shrink();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.timeline,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 16),
          ...request.timeline.map(
                (event) {
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
                              color:
                              AppTheme.getTextColor(context).withOpacity(0.54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Floating Action Button
  // ---------------------------------------------------------------------------

  Widget? _buildFloatingActions(BuildContext context) {
    if (request.status == RequestStatus.delivered ||
        request.status == RequestStatus.cancelled) {
      return null;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => _showCancelDialog(context),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppTheme.getTextColor(context), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel, color: AppTheme.getBackgroundColor(context)),
            SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.cancelRequest,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getBackgroundColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _acceptOffer(BuildContext context, offer) async {
    final provider = Provider.of<RequestProvider>(context, listen: false);
    await provider.acceptOffer(offer);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
               Icon(Icons.check_circle, color: AppTheme.getTextColor(context)),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.offerAccepted(offer.driverName),
                style: TextStyle(color: AppTheme.getTextColor(context)),
              ),
            ],
          ),
          backgroundColor: AppTheme.getBackgroundColor(context),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _retryRequest(BuildContext context, DeliveryRequest request) async {
    final provider = Provider.of<RequestProvider>(context, listen: false);
    await provider.retryRequest();

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.getBorderColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          AppLocalizations.of(context)!.confirmCancel,
          style: TextStyle(color: AppTheme.getTextColor(context)),
        ),
        content: Text(
          AppLocalizations.of(context)!.confirmCancelMessage,
          style: TextStyle(
            color: AppTheme.getTextColor(context).withOpacity(0.70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.no,
                style: TextStyle(color: AppTheme.getTextColor(context))),
          ),
          TextButton(
            onPressed: () async {
              final provider =
                  Provider.of<RequestProvider>(context, listen: false);
              await provider.cancelRequest();
              if (context.mounted) {
                Navigator.pop(ctx);
                Navigator.pop(context);
              }
            },
            child: Text(
              AppLocalizations.of(context)!.yesCancel,
              style: TextStyle(color: AppTheme.getTextColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _getTimeAgo(BuildContext context, DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return AppLocalizations.of(context)!.justNow;
    if (diff.inMinutes < 60)
      return AppLocalizations.of(context)!.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24)
      return AppLocalizations.of(context)!.hoursAgo(diff.inHours);
    return AppLocalizations.of(context)!.daysAgo(diff.inDays);
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
