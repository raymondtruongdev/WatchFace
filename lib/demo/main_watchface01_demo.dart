import 'package:flutter/material.dart';
import 'package:watchface/clock_widget/clock_widget.dart';
import 'package:watchface/clock_widget/complication.dart';

void main() {
  runApp(const MyApp());
}

var complicationBattery = CircleComplication(
    title: 'Battery',
    value: '10%',
    percentage: 0.10,
    radius: 50,
    icon: Icons.battery_full,
    gaugeColor: GaugeColor(
        bgColorInside: const Color(0xff012340),
        bgColorOutside: const Color(0xff012340),
        bgColorValue: const Color(0xff028CFF)));

var complicationStep = CircleComplication(
  title: 'Step',
  value: '5000',
  percentage: 0.53,
  radius: 50,
  icon: Icons.nordic_walking_sharp,
  gaugeColor: GaugeColor(
      bgColorInside: const Color(0xff0A3E19),
      bgColorOutside: const Color(0xff146327),
      bgColorValue: const Color(0xff31F965)),
);

var complicationHr = CircleComplication(
  title: 'HR',
  value: '80',
  percentage: 1.0,
  radius: 50,
  icon: Icons.heart_broken,
  gaugeColor: GaugeColor(
      bgColorInside: const Color.fromARGB(255, 245, 136, 136),
      bgColorOutside: const Color.fromARGB(255, 185, 52, 52),
      bgColorValue: const Color.fromARGB(255, 245, 136, 136)),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circular Watch')),
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
          Image.asset('assets/wf_bg_01.png'), // Clock face image
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..translate(0.0, 100.0),
            child: complicationBattery, // Clock hand image
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..translate(-100.0, 0.0),
            child: complicationStep, // Clock hand image
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..translate(100.0, 0.0),
            child: complicationHr, // Clock hand image
          ),
          const ClockWidget(),
        ])),
      ),
    );
  }
}
