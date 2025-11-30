// ============================================================================
// FILE: lib/widgets/glass_card.dart (UPDATED)
// ============================================================================
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getGlassCardColor(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.getBorderColor(context),
          width: 1,
        ),
        boxShadow: isDark
            ? [
          BoxShadow(
            color: AppTheme.getTextColor(context).withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ]
            : [
          BoxShadow(
            color: AppTheme.getBackgroundColor(context).withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: content,
      );
    }

    return content;
  }
}