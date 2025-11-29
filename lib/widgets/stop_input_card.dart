// ============================================================================
// FILE: lib/widgets/stop_input_card.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/delivery_stop.dart';
import '../services/geocoding_service.dart';
import 'glass_card.dart';

class StopInputCard extends StatefulWidget {
  final DeliveryStop stop;
  final int index;
  final VoidCallback onRemove;
  final Function(DeliveryStop) onUpdate;

  const StopInputCard({
    super.key,
    required this.stop,
    required this.index,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<StopInputCard> createState() => _StopInputCardState();
}

class _StopInputCardState extends State<StopInputCard> {
  final _geocoding = GeocodingService();
  final _addressController = TextEditingController();
  final _orderController = TextEditingController();
  final _feeController = TextEditingController();
  final _notesController = TextEditingController();

  List<AddressSuggestion> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.stop.addressText;
    _orderController.text = widget.stop.orderAmount.toStringAsFixed(2);
    _feeController.text = widget.stop.deliveryFee.toStringAsFixed(2);
    _notesController.text = widget.stop.notes;
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFffffff).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.index + 1}',
                      style: const TextStyle(
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Stop',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (widget.index > 0)
                IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(Icons.delete_outline),
                  color: const Color(0xFFffffff),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Address input with autocomplete
          TextField(
            controller: _addressController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Delivery Address',
              labelStyle: const TextStyle(color: Colors.white60),
              prefixIcon: const Icon(Icons.location_on, color: Color(0xFFffffff)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFffffff), width: 2),
              ),
            ),
            onChanged: _onAddressChanged,
          ),

          if (_showSuggestions && _suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white30),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return ListTile(
                    leading: const Icon(Icons.place, color: Color(0xFFffffff)),
                    title: Text(
                      suggestion.addressText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () => _selectAddress(suggestion),
                  );
                },
              ),
            ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _orderController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Order Amount',
                    labelStyle: const TextStyle(color: Colors.white60),
                    prefixText: '\$ ',
                    prefixStyle: const TextStyle(color: Color(0xFFffffff)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                  ),
                  onChanged: (_) => _updateStop(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _feeController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Delivery Fee',
                    labelStyle: const TextStyle(color: Colors.white60),
                    prefixText: '\$ ',
                    prefixStyle: const TextStyle(color: Color(0xFFffffff)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                  ),
                  onChanged: (_) => _updateStop(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Notes (optional)',
              labelStyle: const TextStyle(color: Colors.white60),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white30),
              ),
            ),
            onChanged: (_) => _updateStop(),
          ),
        ],
      ),
    );
  }

  void _onAddressChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    final suggestions = await _geocoding.getSuggestions(value);
    setState(() {
      _suggestions = suggestions;
      _showSuggestions = true;
    });
  }

  void _selectAddress(AddressSuggestion suggestion) {
    _addressController.text = suggestion.addressText;
    widget.stop.addressText = suggestion.addressText;
    widget.stop.latitude = suggestion.latitude;
    widget.stop.longitude = suggestion.longitude;

    setState(() {
      _showSuggestions = false;
    });

    widget.onUpdate(widget.stop);
  }

  void _updateStop() {
    widget.stop.addressText = _addressController.text;
    widget.stop.orderAmount = double.tryParse(_orderController.text) ?? 0;
    widget.stop.deliveryFee = double.tryParse(_feeController.text) ?? 0;
    widget.stop.notes = _notesController.text;
    widget.onUpdate(widget.stop);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _orderController.dispose();
    _feeController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}