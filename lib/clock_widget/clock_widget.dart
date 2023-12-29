import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pivotOffsetMinute = Offset(1, 74.5);
    const pivotOffsetSecond = Offset(0, 46);
    const pivotOffsetHour = Offset(0, 46);
    var secondAngle = _dateTime.second * 6.0 * pi / 180;
    var minuteAngle =
        (_dateTime.minute * 6 + _dateTime.second * 0.1) * 0.0174533;
    final hourAngle =
        (_dateTime.hour * 30 + _dateTime.minute * 0.5) * 0.0174533; // Hour hand

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(hourAngle)
            ..translate(-pivotOffsetHour.dx, -pivotOffsetHour.dy),
          child: Image.asset('assets/hour_default.png'), // Clock hand image
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(minuteAngle)
            ..translate(-pivotOffsetMinute.dx, -pivotOffsetMinute.dy),
          child: Image.asset('assets/minute_default.png'), // Clock hand image
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(secondAngle)
            ..translate(-pivotOffsetSecond.dx, -pivotOffsetSecond.dy),
          child: Image.asset('assets/second_default.png'), // Clock hand image
        ),
      ],
    );
  }
}
