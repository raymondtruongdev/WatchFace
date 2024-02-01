import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchface/controller/controller.dart';

class ClockAnalog02 extends StatefulWidget {
  const ClockAnalog02({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClockAnalog02State createState() => _ClockAnalog02State();
}

class _ClockAnalog02State extends State<ClockAnalog02> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(
        const Duration(milliseconds: 20), (Timer t) => _updateTime());
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
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);

    double watchSize = (globalController.getWatchSize().value);

    const pivotOffsetMinute = Offset(0, 0);
    const pivotOffsetSecond = Offset(0, 0);
    const pivotOffsetHour = Offset(0, 0);

    var totalSeconds = _dateTime.second + (_dateTime.millisecond / 1000.0);
    var secondAngle = totalSeconds * 6.0 * pi / 180;
    var milisecondAngle = _dateTime.millisecond / 1000.0 * 6.0 * pi / 180;
    var minuteAngle = (_dateTime.minute * 6 + totalSeconds * 0.1) * 0.0174533;
    final hourAngle = (_dateTime.hour * 30 + _dateTime.minute * 0.5) *
        0.0174533; // Hour handr hand

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(hourAngle)
              ..translate(-pivotOffsetHour.dx, -pivotOffsetHour.dy),
            child: Container(
              width: watchSize,
              height: watchSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/clock_widget/WatchFaceAnalog02/image/hour_hand.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ) // Clock hand image
            ),
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(minuteAngle)
              ..translate(-pivotOffsetMinute.dx, -pivotOffsetMinute.dy),
            child: Container(
              width: watchSize,
              height: watchSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/clock_widget/WatchFaceAnalog02/image/minute_hand.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ) // Clock hand image
            ),
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(secondAngle)
              ..translate(-pivotOffsetSecond.dx, -pivotOffsetSecond.dy),
            child: Container(
              width: watchSize,
              height: watchSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/clock_widget/WatchFaceAnalog02/image/second_hand.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ) // Clock hand image
            ),
      ],
    );
  }
}
