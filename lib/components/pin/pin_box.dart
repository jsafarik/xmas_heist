import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinBox extends StatefulWidget {
  const PinBox({
    super.key,
    required this.focus,
    required this.onChanged,
    required this.color,
    required this.controller,
  });

  final FocusNode focus;
  final Function(String content) onChanged;
  final Color color;
  final TextEditingController controller;

  @override
  State<PinBox> createState() => _PinBoxState();
}

class _PinBoxState extends State<PinBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 90,
      child: TextField(
        focusNode: widget.focus,
        textAlign: TextAlign.center,
        controller: widget.controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        style: const TextStyle(fontSize: 60),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color.withOpacity(0.3),
            ),
          ),
        ),
        onChanged: (value) => widget.onChanged(value),
      ),
    );
  }
}
