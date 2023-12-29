// ignore: file_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo AnimationController',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const WatchScreen(),
        // home: CustomPaint(painter: ClockPainter()),
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Demo a rotation using AnimationController')),
            body: const Center(
              child: RotatingImage(),
            )));
  }
}

class RotatingImage extends StatefulWidget {
  const RotatingImage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// To rotate an image around a point that is (8, 156) units below the Center of its Top edge,
// you need to adjust the transformation matrix with an offset value
    const pivotOffset = Offset(8, 156);
    return AnimatedBuilder(
      animation: _controller,
      // child: Image.asset('assets/minute_default.png'),
      child: SvgPicture.asset('assets/minute_default.svg'),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateZ(_controller.value * 2.0 * pi)
            ..translate(-pivotOffset.dx, -pivotOffset.dy),
          alignment: Alignment.topLeft,
          child: child,
        );
      },
    );
  }
}
