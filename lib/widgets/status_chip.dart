// ============================================================================
// FILE: lib/widgets/status_chip.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../models/delivery_request.dart';

class StatusChip extends StatelessWidget {
  final RequestStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: config.color),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: TextStyle(
              color: config.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getStatusConfig(RequestStatus status) {
    switch (status) {
      case RequestStatus.searching:
        return _StatusConfig('Searching', Icons.search, const Color(0xFF00D9FF));
      case RequestStatus.offerReceived:
        return _StatusConfig('Offers', Icons.local_offer, const Color(0xFFFFD600));
      case RequestStatus.accepted:
        return _StatusConfig('Accepted', Icons.check_circle, const Color(0xFF00FF88));
      case RequestStatus.onWayToStore:
        return _StatusConfig('To Store', Icons.store, const Color(0xFF00D9FF));
      case RequestStatus.pickupComplete:
        return _StatusConfig('Picked Up', Icons.shopping_bag, const Color(0xFF00D9FF));
      case RequestStatus.onWayToCustomer:
        return _StatusConfig('Delivering', Icons.delivery_dining, const Color(0xFF00D9FF));
      case RequestStatus.delivered:
        return _StatusConfig('Delivered', Icons.done_all, const Color(0xFF00FF88));
      case RequestStatus.expired:
        return _StatusConfig('Expired', Icons.timer_off, const Color(0xFFFF6B6B));
      case RequestStatus.cancelled:
        return _StatusConfig('Cancelled', Icons.cancel, const Color(0xFFFF006E));
    }
  }
}

class _StatusConfig {
  final String label;
  final IconData icon;
  final Color color;

  _StatusConfig(this.label, this.icon, this.color);
}