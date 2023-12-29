import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo Circle Watch using CustomPaint',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const WatchScreen(),
        // home: CustomPaint(painter: ClockPainter()),
        home: const WatchScreen());
  }
}

//==============================================================================
// Class create WatchScreen using CustomPaint
//==============================================================================

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // This empty setState will trigger the build method
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: ClockPainter());
  }
}

class ClockPainter extends CustomPainter {
  final Paint fillBrush = Paint()..color = const Color(0xff31F965);
  final Paint outlineBrush = Paint()
    ..color = const Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke;
  final Paint centerFillBrush = Paint()..color = const Color(0xFFEAECFF);
  final Paint secHandBrush = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  final Paint minHandBrush = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  final Paint hourHandBrush = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  final Paint dashBrush = Paint()
    ..color = const Color(0xFF000000)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5;

  final DateTime dateTime = DateTime.now();

  ClockPainter();

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    outlineBrush.strokeWidth = size.width / 20;
    secHandBrush.strokeWidth = size.width / 60;
    minHandBrush.strokeWidth = size.width / 30;
    hourHandBrush.strokeWidth = size.width / 24;

    // Shader for minute and hour hands
    Shader handShader = const RadialGradient(
      colors: [Color(0xFF748EF6), Color(0xFF77DDFF)],
    ).createShader(Rect.fromCircle(center: center, radius: radius));
    minHandBrush.shader = handShader;
    hourHandBrush.shader = handShader;

    // Draw the background
    canvas.drawCircle(center, radius - size.width / 20, fillBrush);
    canvas.drawCircle(center, radius - size.width / 20, outlineBrush);

    // Time calculation
    double hour = dateTime.hour.toDouble();
    double minute = dateTime.minute.toDouble();
    double second = dateTime.second.toDouble();

    // Hour hand
    double hourAngle = (hour + minute / 60) * 30 * pi / 180;
    drawHand(canvas, center, hourAngle, radius * 0.4, hourHandBrush);

    // Minute hand
    double minuteAngle = (minute + second / 60) * 6 * pi / 180;
    drawHand(canvas, center, minuteAngle, radius * 0.6, minHandBrush);

    // Second hand
    double secondAngle = second * 6 * pi / 180;
    drawHand(canvas, center, secondAngle, radius * 0.8, secHandBrush);

    // Draw center circle
    canvas.drawCircle(center, radius * 0.12, centerFillBrush);

    // Draw numbers
    drawNumbers(canvas, size, center, radius);
  }

  void drawHand(Canvas canvas, Offset center, double angle, double length,
      Paint paintBrush) {
    double handX = center.dx + length * cos(angle - pi / 2);
    double handY = center.dy + length * sin(angle - pi / 2);
    canvas.drawLine(center, Offset(handX, handY), paintBrush);
  }

  void drawNumbers(Canvas canvas, Size size, Offset center, double radius) {
    double numberCircleRadius = radius * 0.75;
    var outerCircleRadius = radius;
    TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: size.width / 15, // Adjust font size relative to the clock size
    );

    for (double i = -90; i < 270; i += 30) {
      // Draw the number
      double x = center.dx + numberCircleRadius * cos(i * pi / 180);
      double y = center.dy + numberCircleRadius * sin(i * pi / 180);
      int number = i == -90 ? 12 : (i + 90) ~/ 30;
      TextSpan span = TextSpan(style: textStyle, text: number.toString());
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));

      // Draw the dash line
      var x1 = center.dx + outerCircleRadius * cos(i * pi / 180);
      var y1 = center.dy + outerCircleRadius * sin(i * pi / 180);
      var x2 = center.dx + (outerCircleRadius * 0.86) * cos(i * pi / 180);
      var y2 = center.dy + (outerCircleRadius * 0.86) * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
