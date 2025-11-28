// ============================================================================
// FILE: lib/widgets/countdown_timer.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onComplete;
  final Color? color;

  const CountdownTimer({
    super.key,
    required this.duration,
    this.onComplete,
    this.color,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining.inSeconds > 0) {
        setState(() {
          _remaining = Duration(seconds: _remaining.inSeconds - 1);
        });
      } else {
        _timer?.cancel();
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? const Color(0xFF00D9FF);
    final minutes = _remaining.inMinutes;
    final seconds = _remaining.inSeconds % 60;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}