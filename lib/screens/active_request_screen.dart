// ============================================================================
// FILE: lib/screens/active_request_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/delivery_request.dart';
import '../providers/request_provider.dart';
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
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
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
                      return const Center(
                        child: Text(
                          'Request not found',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildStatusCard(activeRequest),
                        const SizedBox(height: 16),
                        if (activeRequest.status == RequestStatus.searching ||
                            activeRequest.status == RequestStatus.offerReceived)
                          _buildTimerCard(activeRequest),
                        const SizedBox(height: 16),
                        if (activeRequest.offers.isNotEmpty &&
                            activeRequest.status != RequestStatus.accepted)
                          ..._buildOffersList(context, activeRequest),
                        if (activeRequest.status == RequestStatus.searching &&
                            activeRequest.offers.isEmpty)
                          _buildSearchingCard(),
                        const SizedBox(height: 16),
                        if (activeRequest.status == RequestStatus.expired)
                          _buildExpiredCard(context, activeRequest),
                        _buildStopsCard(activeRequest),
                        const SizedBox(height: 16),
                        _buildTimelineCard(activeRequest),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Request #${request.id.substring(request.id.length - 6)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _getTimeAgo(request.createdAt),
                  style: const TextStyle(
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

  Widget _buildStatusCard(DeliveryRequest request) {
    return GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Status',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
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
                const Text(
                  'Driver',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request.offers.firstWhere((o) => o.id == request.acceptedOfferId).driverName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTimerCard(DeliveryRequest request) {
    if (request.remainingTime == null) return const SizedBox.shrink();

    return GlassCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, color: Color(0xFFFF006E), size: 28),
              const SizedBox(width: 12),
              const Text(
                'Request Expires In',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CountdownTimer(
            duration: request.remainingTime!,
            color: const Color(0xFFFF006E),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOffersList(BuildContext context, DeliveryRequest request) {
    return [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Available Offers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      ...request.offers.map((offer) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: OfferCard(
          offer: offer,
          onAccept: () => _acceptOffer(context, offer),
        ),
      )),
    ];
  }

  Widget _buildSearchingCard() {
    return GlassCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search,
              size: 48,
              color: Color(0xFF00D9FF),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Searching for Drivers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'re notifying nearby drivers about your request',
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

  Widget _buildExpiredCard(BuildContext context, DeliveryRequest request) {
    return GlassCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF006E).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer_off,
              size: 48,
              color: Color(0xFFFF006E),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Request Expired',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No drivers accepted within the time limit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _retryRequest(context, request),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh),
                SizedBox(width: 8),
                Text(
                  'Retry Request',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopsCard(DeliveryRequest request) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Stops',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...request.stops.asMap().entries.map((entry) {
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
                      color: const Color(0xFF00D9FF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFF00D9FF),
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
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${stop.orderAmount.toStringAsFixed(2)} + \$${stop.deliveryFee.toStringAsFixed(2)} fee',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(color: Colors.white30, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${request.grandTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00D9FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(DeliveryRequest request) {
    if (request.timeline.isEmpty) return const SizedBox.shrink();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
                    decoration: const BoxDecoration(
                      color: Color(0xFF00D9FF),
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
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(time),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
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
          side: const BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel, color: Color(0xFFFF006E)),
            SizedBox(width: 8),
            Text(
              'Cancel Request',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF006E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _acceptOffer(BuildContext context, offer) async {
    final provider = Provider.of<RequestProvider>(context, listen: false);
    await provider.acceptOffer(offer);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00FF88)),
              const SizedBox(width: 12),
              Text('Offer from ${offer.driverName} accepted!'),
            ],
          ),
          backgroundColor: const Color(0xFF1A1F3A),
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
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Cancel Request?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to cancel this delivery request?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              final provider = Provider.of<RequestProvider>(context, listen: false);
              await provider.cancelRequest();
              if (context.mounted) {
                Navigator.pop(ctx);
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Color(0xFFFF006E)),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}