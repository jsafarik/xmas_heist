import 'dart:async';

import 'package:flutter/widgets.dart';

class Countdown extends StatefulWidget {
  const Countdown(
      {super.key, required this.duration, required this.textStyle, required this.shouldCancel, this.shouldStop});

  final Duration duration;
  final TextStyle textStyle;
  final Function shouldCancel;
  final bool Function()? shouldStop;

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Duration internalDuration;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    internalDuration = widget.duration;
    initTimer();
  }

  void initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        bool shouldStop = widget.shouldStop == null ? false : widget.shouldStop!();
        if (widget.duration.inSeconds > 0 && !widget.shouldCancel()) {
          internalDuration = Duration(seconds: internalDuration.inSeconds - (shouldStop ? 0 : 1));
        } else {
          timer.cancel();
        }
      });
    });
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String hours = internalDuration.inHours.toString().padLeft(2, '0');
    String minutes = internalDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = internalDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text("$hours:$minutes:$seconds", style: widget.textStyle);
  }
}
