// ============================================================================
// FILE: lib/widgets/glass_card.dart
// ============================================================================
import 'package:flutter/material.dart';

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
    final content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A), // Dark gray instead of white.withOpacity
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF2A2A2A), // Border gray
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05), // Subtle white glow
            blurRadius: 20,
            spreadRadius: -5,
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