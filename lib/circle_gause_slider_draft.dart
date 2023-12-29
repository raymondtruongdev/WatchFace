import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circle Gauge Example')),
        body: const Center(
          child: CircleGauge(),
        ),
      ),
    );
  }
}

class CircleGauge extends StatefulWidget {
  const CircleGauge({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CircleGaugeState createState() => _CircleGaugeState();
}

class _CircleGaugeState extends State<CircleGauge> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomPaint(
          size: const Size(200, 200),
          painter: CircleGaugePainter(value: _value),
        ),
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
      ],
    );
  }
}

class CircleGaugePainter extends CustomPainter {
  final double value; // Giá trị của đồng hồ đo, từ 0.0 đến 1.0

  CircleGaugePainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // Vẽ vòng tròn nền
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Vẽ vòng tròn đo giá trị
    paint.color = Colors.blue;
    double progressRadians = 2 * pi * value;
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -pi / 2,
      progressRadians,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleGaugePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
