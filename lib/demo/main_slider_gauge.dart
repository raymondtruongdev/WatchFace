import 'package:flutter/material.dart';
import 'package:watchface/clock_widget/complication.dart';

void main() => runApp(const MyApp());

double _value = 0.0;
var complicationBattery = CircleComplication(
    title: 'Battery',
    value: '50%',
    percentage: 0.350,
    radius: 50,
    icon: Icons.battery_full,
    gaugeColor: GaugeColor(
        bgColorInside: const Color(0xff012340),
        bgColorOutside: const Color(0xff012340),
        bgColorValue: const Color(0xff028CFF)));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circle Gauge Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 100, height: 100, child: complicationBattery),
              SizedBox(
                width: 200,
                child: Slider(
                  value: _value,
                  onChanged: (newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: CircleComplication(
                    title: 'Battery',
                    value: '${(_value * 100).toStringAsFixed(0)} %',
                    percentage: _value,
                    radius: 50,
                    icon: Icons.battery_full,
                    gaugeColor: GaugeColor(
                        bgColorInside: const Color(0xff012340),
                        bgColorOutside: const Color(0xff012340),
                        bgColorValue: const Color(0xff028CFF))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
