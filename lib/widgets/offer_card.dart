// ============================================================================
// FILE: lib/widgets/offer_card.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/offer.dart';
import '../utils/theme.dart';
import 'glass_card.dart';
import 'countdown_timer.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onAccept;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.driverName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: AppTheme.accentYellow),
                      const SizedBox(width: 4),
                      Text(
                        offer.driverRating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.getTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (offer.isCounterOffer)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentRed.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.accentRed),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.counter,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.accentRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.proposedFee,
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                  ),
                  Text(
                    '\$${offer.proposedFee.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: offer.isCounterOffer
                          ? AppTheme.accentRed
                          : AppTheme.getTextColor(context),
                    ),
                  ),
                  if (offer.isCounterOffer)
                    Text(
                      AppLocalizations.of(context)!.original(
                          '\$${offer.originalDeliveryFee.toStringAsFixed(2)}'),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.getTextColor(context),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.eta,
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                  ),
                  Text(
                    AppLocalizations.of(context)!.minutes(offer.etaMinutes),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountdownTimer(
                duration: offer.remainingTime,
                color: AppTheme.accentOrange,
              ),
              ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getTextColor(context),
                  foregroundColor: AppTheme.getBackgroundColor(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.accept,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
