// ============================================================================
// FILE: lib/widgets/status_chip.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/delivery_request.dart';
import '../utils/theme.dart';

class StatusChip extends StatelessWidget {
  final RequestStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(context, status);

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
          Icon(config.icon, size: 14, color: AppTheme.getTextColor(context)),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: TextStyle(
              color: AppTheme.getTextColor(context),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getStatusConfig(BuildContext context, RequestStatus status) {
    switch (status) {
      case RequestStatus.searching:
        return _StatusConfig(
            AppLocalizations.of(context)!.searching, Icons.search, const Color(0xFF00D9FF));
      case RequestStatus.offerReceived:
        return _StatusConfig(AppLocalizations.of(context)!.offerReceived,
            Icons.local_offer, const Color(0xFFFFD600));
      case RequestStatus.accepted:
        return _StatusConfig(AppLocalizations.of(context)!.accepted,
            Icons.check_circle, const Color(0xFF00FF88));
      case RequestStatus.onWayToStore:
        return _StatusConfig(AppLocalizations.of(context)!.toStore, Icons.store,
            const Color(0xFF00D9FF));
      case RequestStatus.pickupComplete:
        return _StatusConfig(AppLocalizations.of(context)!.pickedUp,
            Icons.shopping_bag, const Color(0xFF00D9FF));
      case RequestStatus.onWayToCustomer:
        return _StatusConfig(AppLocalizations.of(context)!.delivering,
            Icons.delivery_dining, const Color(0xFF00D9FF));
      case RequestStatus.delivered:
        return _StatusConfig(AppLocalizations.of(context)!.delivered,
            Icons.done_all, const Color(0xFF00FF88));
      case RequestStatus.expired:
        return _StatusConfig(AppLocalizations.of(context)!.expired,
            Icons.timer_off, const Color(0xFFFF6B6B));
      case RequestStatus.cancelled:
        return _StatusConfig(AppLocalizations.of(context)!.cancelled,
            Icons.cancel, const Color(0xFFFF006E));
    }
  }
}

class _StatusConfig {
  final String label;
  final IconData icon;
  final Color color;

  _StatusConfig(this.label, this.icon, this.color);
}