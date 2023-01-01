import 'package:flutter/widgets.dart';
import 'package:xmas_heist/components/pin/pin_box.dart';

class PinInput extends StatefulWidget {
  const PinInput({
    super.key,
    required this.length,
    required this.pin,
    this.onChange,
    this.onSuccess,
    this.onFail,
  });

  final void Function(String content)? onChange;
  final void Function()? onSuccess;
  final void Function()? onFail;
  final int length;
  final String pin;

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late List<FocusNode> focusNodes;
  late List<Widget> pinBoxes;
  late List<String> pin;
  late List<TextEditingController> controllers;

  void onChanged(String content) {
    int currentIndex = focusNodes.indexWhere((element) => element.hasFocus);
    pin[currentIndex] = content;
    if (content.trim().isNotEmpty) {
      if (currentIndex + 1 < focusNodes.length) {
        focusNodes.elementAt(currentIndex + 1).requestFocus();
      }
    }

    String currentPin = pin.join("").trim();

    if (widget.onChange != null) {
      widget.onChange!(currentPin);
    }

    if (currentPin == widget.pin && widget.onSuccess != null) {
      widget.onSuccess!();
    }

    if (currentPin.length == widget.length && currentPin != widget.pin) {
      if (widget.onFail != null) {
        widget.onFail!();
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        for (int i = 0; i < widget.length; i++) {
          controllers[i].text = "";
          pin[i] = "";
        }
        focusNodes.first.requestFocus();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pin = List.generate(widget.length, (index) => "");
    focusNodes = List.generate(widget.length, (index) => FocusNode());
    controllers = List.generate(widget.length, (index) => TextEditingController());
    pinBoxes = List.generate(
      widget.length,
      (index) => PinBox(
        focus: focusNodes.elementAt(index),
        onChanged: onChanged,
        color: const Color.fromRGBO(1, 1, 1, 1),
        controller: controllers.elementAt(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pinBoxes,
    );
  }
}
