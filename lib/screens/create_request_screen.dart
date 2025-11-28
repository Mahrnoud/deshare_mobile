// ============================================================================
// FILE: lib/screens/create_request_screen.dart
// ============================================================================
import 'package:flutter/material.dart';
import '../models/delivery_stop.dart';
import '../widgets/glass_card.dart';
import '../widgets/stop_input_card.dart';
import 'request_confirmation.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final List<DeliveryStop> _stops = [
    DeliveryStop(
      id: 'stop_0',
      addressText: '',
      orderAmount: 0,
      deliveryFee: 5.0,
    ),
  ];

  void _addStop() {
    setState(() {
      _stops.add(DeliveryStop(
        id: 'stop_${_stops.length}',
        addressText: '',
        orderAmount: 0,
        deliveryFee: 5.0,
      ));
    });
  }

  void _removeStop(int index) {
    setState(() {
      _stops.removeAt(index);
    });
  }

  void _updateStop(int index, DeliveryStop stop) {
    setState(() {
      _stops[index] = stop;
    });
  }

  bool get _canProceed {
    return _stops.every((s) =>
    s.addressText.isNotEmpty &&
        s.orderAmount > 0 &&
        s.deliveryFee >= 0
    );
  }

  double get _subtotal => _stops.fold(0, (sum, s) => sum + s.orderAmount);
  double get _totalFees => _stops.fold(0, (sum, s) => sum + s.deliveryFee);
  double get _grandTotal => _subtotal + _totalFees;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF1A1F3A),
              Color(0xFF0A0E27),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ..._stops.asMap().entries.map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: StopInputCard(
                        key: ValueKey(entry.value.id),
                        stop: entry.value,
                        index: entry.key,
                        onRemove: () => _removeStop(entry.key),
                        onUpdate: (stop) => _updateStop(entry.key, stop),
                      ),
                    )),
                    const SizedBox(height: 8),
                    _buildAddStopButton(),
                    const SizedBox(height: 24),
                    _buildSummaryCard(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Delivery Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${_stops.length} stop(s)',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddStopButton() {
    return GlassCard(
      onTap: _addStop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Color(0xFF00D9FF)),
          ),
          const SizedBox(width: 12),
          const Text(
            'Add Another Stop',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Subtotal (Orders)', _subtotal, const Color(0xFF00FF88)),
          const SizedBox(height: 8),
          _buildSummaryRow('Delivery Fees', _totalFees, const Color(0xFFFFD600)),
          const Divider(color: Colors.white30, height: 24),
          _buildSummaryRow('Grand Total', _grandTotal, const Color(0xFF00D9FF), isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, Color color, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: Colors.white70,
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

  Widget _buildFloatingButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _canProceed ? _proceedToConfirmation : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D9FF),
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.white24,
          disabledForegroundColor: Colors.white38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: const Color(0xFF00D9FF).withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_forward, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Review Request',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RequestConfirmationScreen(stops: _stops),
      ),
    );
  }
}