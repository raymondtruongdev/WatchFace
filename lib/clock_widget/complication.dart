import 'dart:math';
import 'package:flutter/material.dart';
// This class use to make a CircleComplication with Gauge Circle
/* Example:
var complicationBattery = CircleComplication(
        title: 'Battery',
        value: '50%',
        percentage: 0.350,
        radius: 150,
        icon: Icons.battery_full,
        gaugeColor: GaugeColor(
            bgColorInside: const Color(0xff012340),
            bgColorOutside: const Color(0xff012340),
            bgColorValue: const Color(0xff028CFF)));
*/

class GaugeColor {
  Color bgColorInside;
  Color bgColorOutside;
  Color bgColorValue;

  GaugeColor({
    this.bgColorInside = const Color(0xff012340),
    this.bgColorOutside = const Color(0xff012340),
    this.bgColorValue = const Color(0xff028CFF),
  });
}

class CircleComplication extends StatelessWidget {
  final double percentage;
  final double radius;
  final String title;
  final String value;
  final IconData icon;
  final GaugeColor gaugeColor;

  const CircleComplication({
    Key? key,
    this.percentage = 0.8,
    required this.title,
    required this.value,
    required this.radius,
    required this.icon,
    required this.gaugeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(radius * 2, radius * 2),
          painter: CircleGaugePainter(
              percentage: percentage, gaugeColor: gaugeColor),
        ),
        _showGaugeContent(),
      ],
    );
  }

  // Show contend inside of gauge
  Widget _showGaugeContent() {
    double fontSizeContent = radius / 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: radius / 50),
            child: DefaultTextStyle(
              style: TextStyle(fontSize: fontSizeContent, color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(icon,
                      size: fontSizeContent * 2.5,
                      color: gaugeColor.bgColorValue),
                  Text(title),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: radius / 20),
            child: DefaultTextStyle(
              style:
                  TextStyle(fontSize: fontSizeContent * 2, color: Colors.white),
              child: Text(value),
            ),
          ),
        ),
      ],
    );
  }
}

class CircleGaugePainter extends CustomPainter {
  final double percentage;
  final GaugeColor gaugeColor;

  CircleGaugePainter({
    required this.percentage,
    required this.gaugeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double strokeWidth = size.width / 2 / 10;
    // Draw the inner circle
    Paint innerCirclePaint = Paint()
      ..color = gaugeColor.bgColorInside
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 2, innerCirclePaint);

    // Draw the outer circle ring
    Paint outerRingPaint = Paint()
      ..color = gaugeColor.bgColorOutside
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, size.width / 2, outerRingPaint);

    Paint outerRingPaint2 = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, size.width / 2 - strokeWidth, outerRingPaint2);

    // Draw the gauge progress arc
    Paint progressArcPaint = Paint()
      ..color = gaugeColor.bgColorValue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    double progressRadians = 2 * pi * percentage;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        -pi / 2, progressRadians, false, progressArcPaint);
  }

  @override
  bool shouldRepaint(CircleGaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
