import 'package:flutter/widgets.dart';

import '../components/countdown.dart';
import '../components/pin/pin_input.dart';

class Bomb extends StatefulWidget {
  const Bomb({super.key, required this.pin});

  final String pin;

  @override
  State<Bomb> createState() => _BombState();
}

class _BombState extends State<Bomb> {
  Color color = const Color.fromARGB(255, 201, 71, 56);
  bool shouldCancel = false;

  @override
  void initState() {
    super.initState();
  }

  void onSuccess() {
    setState(() {
      shouldCancel = true;
      color = const Color.fromARGB(255, 97, 201, 56);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Countdown(
                duration: const Duration(hours: 1),
                shouldCancel: () => shouldCancel,
                textStyle: TextStyle(
                  fontSize: 120,
                  color: color,
                  shadows: [Shadow(color: color.withOpacity(0.2), blurRadius: 20)],
                ),
              ),
            ),
          ),
          Expanded(
            child: PinInput(
              onSuccess: onSuccess,
              length: 4,
              pin: widget.pin,
            ),
          )
        ],
      ),
    );
  }
}
